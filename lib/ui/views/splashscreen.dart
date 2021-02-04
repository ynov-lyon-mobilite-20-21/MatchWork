import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/services/image_loader.dart';
import 'package:match_work/core/services/storage_manager.dart';
import 'package:match_work/core/utils/device_bar_utils.dart';
import 'package:match_work/ui/views/home_view.dart';
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
  final splashDelay = 3;
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
    DeviceBarUtils.showStatusBar(false);
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

  Future<void> navigationPage() async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    bool isAuthenticated =
        await Provider.of<AuthenticationService>(context, listen: false)
            .isUserLoggedIn();

    StorageManager.readData("isFirstLaunch").then((isFirstLaunch) => {
          if (isFirstLaunch == null)
            {Navigator.pushReplacementNamed(context, RoutePath.Tutorial)}
          else if (isAuthenticated)
            {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomeView()))
            }
          else
            {Navigator.pushReplacementNamed(context, RoutePath.Start)}
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppBackgroundImages.BackgroundSplashScreen),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: screenHeight * 0.0025, right: screenHeight * 0.006),
              alignment: Alignment.topRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.asset(
                    AppLogoImages.LogoTuba,
                    width: screenWidth / 6,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: screenHeight * 0.018),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    AppLogoImages.LogoMatchWorkText,
                    width: MediaQuery.of(context).size.width,
                    height: screenHeight / 2,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: screenHeight * 0.28),
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
