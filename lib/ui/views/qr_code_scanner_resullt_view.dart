import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/constants/string.dart';

class QrCodeScannerSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppBackgroundImages.BackgroundQrCode),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [
              Container(
                padding: EdgeInsets.only(top: screenHeight / 8),
                alignment: Alignment.center,
                child: Text(
                  "qr code\nvalidée".toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 28),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight / 15),
                child: Container(
                  alignment: Alignment.center,
                  height: screenHeight / 3,
                  width: screenHeight / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.QrCodeSuccess),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: screenHeight / 15),
                child: Text(
                  "Votre authentification a été validée.\nVous pouvez vous connecter à\nMatchWork",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  width: screenHeight / 3,
                  height: screenHeight / 8,
                  padding: EdgeInsets.only(top: screenHeight / 15),
                  child: RaisedButton(
                    child: Text(
                      "go".toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushNamedAndRemoveUntil(RoutePath.Tutorial,
                            (Route<dynamic> route) => false),
                    color: AppColors.AccentColor,
                  )),
            ])));
  }
}

class QrCodeScannerFailed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppBackgroundImages.BackgroundQrCode),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [
              Container(
                padding: EdgeInsets.only(top: screenHeight / 8),
                alignment: Alignment.center,
                child: Text(
                  "qr code\nrefusée".toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 28),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight / 15),
                child: Container(
                  alignment: Alignment.center,
                  height: screenHeight / 3,
                  width: screenHeight / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.QrCodeFailed),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: screenHeight / 15),
                child: Text(
                  "Votre authentification a été\nrefusée. Le QR code est erroné ou\nincorrect, veuillez réessayer.",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                    padding: EdgeInsets.only(top: screenHeight / 15),
                    child: Text(BackTitle)),
              ),
            ])));
  }
}
