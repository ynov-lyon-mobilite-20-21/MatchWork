import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/constants/string.dart';
import 'package:match_work/core/utils/device_bar_utils.dart';
import 'package:match_work/ui/views/qr_code_scanner_result_view.dart';

class CodeView extends StatefulWidget {
  @override
  _CodeViewState createState() => _CodeViewState();
}

class _CodeViewState extends State<CodeView> {
  final FocusScopeNode _node = FocusScopeNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    DeviceBarUtils.showStatusBar(false);
    TextEditingController _numberOneController = TextEditingController();
    TextEditingController _numberTwoController = TextEditingController();
    TextEditingController _numberThreeController = TextEditingController();
    TextEditingController _numberFourController = TextEditingController();
    TextEditingController _numberFiveController = TextEditingController();
    TextEditingController _numberSixController = TextEditingController();

    bool isValidForm() {
      if (_numberOneController.text != null &&
          _numberTwoController.text != null &&
          _numberThreeController.text != null &&
          _numberFourController.text != null &&
          _numberFiveController.text != null &&
          _numberSixController.text != null)
        return true;
      else
        return false;
    }

    String getCode() {
      return "${_numberOneController.text}${_numberTwoController.text}${_numberThreeController.text}${_numberFourController.text}${_numberFiveController.text}${_numberSixController.text}";
    }

    void checkCode() {
      if (isValidForm()) {
        String code = getCode();
        print("entering $code ----> real code $CodeKey");
        if (code == CodeKey) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QrCodeScannerSuccess()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QrCodeScannerFailed()),
          );
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(AppBackgroundImages.BackgroundQrCode),
          fit: BoxFit.cover,
        )),
        child: Column(children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  top: screenHeight / 20, left: screenHeight / 20),
              child: Text(
                BackTitle,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: screenHeight / 10),
            child: Text(
              "Entrez \nle code".toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: screenHeight / 10,
                right: 50,
                left: 50,
              ),
              child: Form(
                  key: _formKey,
                  child: FocusScope(
                    node: _node,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DigitInputText(
                            controller: _numberOneController,
                            node: _node,
                          ),
                          DigitInputText(
                            controller: _numberTwoController,
                            node: _node,
                          ),
                          DigitInputText(
                            controller: _numberThreeController,
                            node: _node,
                          ),
                          DigitInputText(
                            controller: _numberFourController,
                            node: _node,
                          ),
                          DigitInputText(
                            controller: _numberFiveController,
                            node: _node,
                          ),
                          DigitInputText(
                            controller: _numberSixController,
                            node: _node,
                          ),
                        ]),
                  ))),
          Container(
              width: screenHeight / 2.8,
              height: screenHeight / 8,
              padding: EdgeInsets.only(top: screenHeight / 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.AccentColor, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: Text(
                  "confirmez".toUpperCase(),
                ),
                onPressed: () async => checkCode(),
              )),
        ]),
      ),
    );
  }
}

class DigitInputText extends StatelessWidget {
  final controller;
  final node;
  DigitInputText({this.controller, this.node}) : assert(controller != null);

  @override
  Widget build(BuildContext context) {
    double borderRadius = 5;
    return Container(
      width: 30,
      child: TextFormField(
          maxLength: 1,
          showCursor: false,
          style: TextStyle(fontSize: 20.0, color: Colors.black),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          autofocus: true,
          onChanged: (_) => FocusScope.of(context).nextFocus(),
          onFieldSubmitted: (v) => {FocusScope.of(context).requestFocus(node)},
          controller: controller,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          )),
    );
  }
}
