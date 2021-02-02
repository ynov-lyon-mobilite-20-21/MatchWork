import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/services/storage_manager.dart';
import 'package:match_work/core/utils/image_loader.dart';
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
  String _logo = AppLogoImages.SplashScreenLogo;
  String _backgroundImage = AppBackgroundImages.SplashscreenBackground;
  String _topRightLogo = AppLogoImages.TubaLogo;
  PackageInfo _packageInfo = PackageInfo(
    version: 'Unknown',
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadImages();
  }

  _preloadImages() {
    ImageLoader loader = ImageLoader();
    loader.loadImages(context);
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

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    Navigator.of(context).popUntil((route) => route.isFirst);

    bool isAuthenticated =
    await Provider.of<AuthenticationService>(context, listen: false)
        .isUserLoggedIn();

    bool isFirstLaunch = await StorageManager.readData("isFirstLaunch") as bool;
    if (isFirstLaunch == null) {
      isFirstLaunch = true;
    }

    if(isFirstLaunch){
      Navigator.pushReplacementNamed(context, RoutePath.Tutorial);
    } else if (isAuthenticated) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => HomeView()));
    } else {
      Navigator.pushReplacementNamed(context, RoutePath.Start);
    }
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
