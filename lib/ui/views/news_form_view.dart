import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/models/news.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/viewmodels/views/news_form_view_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/widgets/profile_picture_widget.dart';
import 'package:provider/provider.dart';

class NewsFormView extends StatefulWidget {
  final News news;

  NewsFormView({this.news});

  @override
  _NewsFormViewState createState() => _NewsFormViewState();
}

class _NewsFormViewState extends State<NewsFormView> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Provider.of<ThemeProvider>(context).getTheme();

    return BaseWidget<NewsFormViewModel>(
      onModelReady: (model) => model.initialData(),
      model: NewsFormViewModel(
          authenticationService: Provider.of(context), news: widget.news),
      builder: (context, model, widget) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        color: theme.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBar(
              backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
              iconTheme: IconThemeData(color: theme.textTheme.subtitle1.color),
              centerTitle: true,
              actions: [
                FlatButton(
                  child: Text(
                    model.news == null ? "Publier" : "Modifier",
                    style: TextStyle(color: AppColors.CircleAvatarBorderColor),
                  ),
                  onPressed: () async {
                    bool success = model.news == null
                        ? await model.postNews()
                        : await model.editNews();
                    if (success) {
                      Navigator.pop(context);
                    }
                  },
                )
              ],
              title: Text(
                model.news == null ? "Nouveau post" : "Modifier post",
                style: TextStyle(color: theme.textTheme.headline2.color),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          ProfilePictureWidget(
                            path: Provider.of<AuthenticationService>(context)
                                .currentUser
                                .pictureUrl,
                            radius: 20.0,
                            borderThickness: 2.0,
                            backgroundColor: theme.indicatorColor,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            Provider.of<AuthenticationService>(context)
                                .currentUser
                                .displayName(),
                            style: theme.textTheme.bodyText1.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          )
                        ],
                      ),
                      TextField(
                          style: theme.textTheme.subtitle1,
                          controller: model.controller,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintStyle: theme.textTheme.subtitle1,
                            hintText: "De quoi voulez-vous parler?",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          )),
                      model.image != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Card(
                                color: theme.cardColor,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [],
                                    ),
                                    Stack(
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              maxHeight: 250.0),
                                          child: Image.file(
                                            model.image,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            onTap: () => model.removeImage(),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: model.image == null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  color: theme.bottomNavigationBarTheme.backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ajouter une image",
                          style: theme.textTheme.subtitle1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.add_a_photo,
                                color: theme.textTheme.subtitle1.color,
                              ),
                              onTap: () async => await model.getImgFromCamera(),
                            ),
                            InkWell(
                              child: Icon(Icons.add_photo_alternate,
                                  color: theme.textTheme.subtitle1.color),
                              onTap: () async =>
                                  await model.getImgFromGallery(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
