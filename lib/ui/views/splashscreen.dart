import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/ui/views/home_view.dart';
import 'package:match_work/ui/views/login_view.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = AppColors.PrimaryColor;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 5;
  String _logo = AppImages.LogoMatchWorkText;
  String _backgroundImage = AppImages.BackgroundSplashScreen;
  String _topRightLogo = AppImages.LogoTuba;
  PackageInfo _packageInfo = PackageInfo(
    version: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    _loadWidget();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    bool isAuthenticated =
        await Provider.of<AuthenticationService>(context, listen: false)
            .isUserLoggedIn();
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                isAuthenticated ? HomeView() : LoginView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              _backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                _topRightLogo,
                width: 60,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              _logo,
              width: MediaQuery.of(context).size.width,
              height: 300,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Loading...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "version : ${_packageInfo.version}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
