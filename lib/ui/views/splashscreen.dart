import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/services/image_loader.dart';
import 'package:match_work/ui/views/home_view.dart';
import 'package:match_work/ui/views/tutorial_view.dart';
import 'package:match_work/ui/widgets/helpers/space.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = AppColors.PrimaryColor;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 5;
  double screenHeight;
  double screenWidth;

  PackageInfo _packageInfo = PackageInfo(
    version: 'Unknown',
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadImages();
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }

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

  _preloadImages() {
    ImageLoader loader = ImageLoader();
    loader.loadImages(context);
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => TutorialView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppBackgroundImages.SplashscreenBackground),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 2, right: 5),
              alignment: Alignment.topRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.asset(
                    AppLogoImages.TubaLogo,
                    width: screenWidth / 6,
                  ),
                ],
              ),
            ),
            Space(size: screenHeight / 8),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    AppLogoImages.LogoTextBelow,
                    width: MediaQuery.of(context).size.width,
                    height: screenHeight / 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                  ),
                ],
              ),
            ),
            Space(size: screenHeight / 8),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Loading...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "version : ${_packageInfo.version}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
