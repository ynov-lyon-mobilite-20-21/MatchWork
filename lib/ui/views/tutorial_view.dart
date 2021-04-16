import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/services/storage_manager.dart';
import 'package:match_work/core/utils/device_bar_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_view.dart';

final List<String> imgList = AppOnBoardingImage.onBoardingImages;

class TutorialView extends StatefulWidget {
  @override
  _TutorialViewState createState() => _TutorialViewState();
}

addStringToSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isFirstLaunchSwipe', true);
}

class _TutorialViewState extends State<TutorialView> {
  @override
  Widget build(BuildContext context) {
    DeviceBarUtils.changeStatusBarColor(Colors.transparent);

    final double height = MediaQuery.of(context).size.height;

    return Container(
      child: Stack(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
                height: height,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {});
                }),
            items: imgList
                .map((image) => Container(
                      height: height * 1.255,
                      child: Container(
                          child: Stack(children: [
                        Image.asset(image,
                            fit: BoxFit.cover, height: height * 1.255),
                        Container(
                          child: CarouselButtonWidget(
                              images: imgList, currentImage: image),
                        )
                      ])),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class CarouselButtonWidget extends StatefulWidget {
  final List<String> images;
  final String currentImage;

  const CarouselButtonWidget({Key key, this.images, this.currentImage})
      : super(key: key);

  @override
  _CarouselButtonWidgetState createState() => _CarouselButtonWidgetState();
}

class _CarouselButtonWidgetState extends State<CarouselButtonWidget> {
  static bool isVisible = false;
  bool test;

  @override
  Widget build(BuildContext context) {
    var lastImage = widget.images.last;
    var _current = widget.images.indexOf(widget.currentImage);
    final double height = MediaQuery.of(context).size.height;

    if (_current == widget.images.indexOf(lastImage) || isVisible) {
      isVisible = true;
      return Container(
          padding: EdgeInsets.only(left: height * 0.37, top: height * 0.94),
          child: Container(
            color: AppColors.PrimaryColor,
            height: height * 0.056,
            child: TextButton(
                onPressed: () async {
                  addStringToSF();
                  StorageManager.saveData("isFirstLaunch", false);
                  bool isAuthenticated =
                      await Provider.of<AuthenticationService>(context,
                              listen: false)
                          .isUserLoggedIn();
                  if (isAuthenticated) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomeView()));
                  } else {
                    Navigator.pushNamed(context, RoutePath.Start);
                  }
                },
                child: Text("Continuer",
                    style: TextStyle(fontSize: 20, color: Colors.white))),
          ));
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.map((url) {
          int index = imgList.indexOf(url);
          return Container(
            width: height * 0.033,
            height: height * 0.016,
            margin: EdgeInsets.only(top: height * 0.96),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index ? Colors.white : AppColors.AccentColor,
            ),
          );
        }).toList(),
      );
    }
  }
}
