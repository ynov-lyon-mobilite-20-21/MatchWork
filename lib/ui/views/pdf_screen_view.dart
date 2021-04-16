import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:match_work/core/models/app_file.dart';
import 'package:match_work/core/utils/storage_utils.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class PDFScreenView extends StatefulWidget {
  final AppFile pdf;

  PDFScreenView({Key key, this.pdf}) : super(key: key);

  _PDFScreenViewState createState() => _PDFScreenViewState();
}

class _PDFScreenViewState extends State<PDFScreenView>
    with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).getTheme();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pdf.title),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<File>(
        future: StorageUtils.assetToFile(
            widget.pdf.path, '${widget.pdf.title}.pdf'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PDFView(
              pdfData: snapshot.data.readAsBytesSync(),
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: true,
              pageSnap: true,
              defaultPage: currentPage,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation:
                  false, // if set to true the link is handled in flutter
              onRender: (_pages) {
                setState(() {
                  pages = _pages;
                  isReady = true;
                });
              },
              onError: (error) {
                setState(() {
                  errorMessage = error.toString();
                });
                print(error.toString());
              },
              onPageError: (page, error) {
                setState(() {
                  errorMessage = '$page: ${error.toString()}';
                });
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onLinkHandler: (String uri) {
                print('goto uri: $uri');
              },
              onPageChanged: (int page, int total) {
                print('page change: $page/$total');
                setState(() {
                  currentPage = page;
                });
              },
            );
          }
          return LoaderWidget();
        },
      ),
    );
  }
}
