import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/constants/string.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/utils/device_bar_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_view.dart';

class OnBoardingView extends StatefulWidget {
  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = new PageController(initialPage: 0);

  int currentPage;
  bool isVisible;

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    isVisible = false;
  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(StorageFirstaunchKey, false);
  }

  int getCurrentIndex(int page) {
    if (page == 0) {
      return page;
    } else if (page == AppOnBoardingImage.onBoardingImages.length - 1) {
      isVisible = true;
      return page % AppOnBoardingImage.onBoardingImages.length;
    } else {
      return page % AppOnBoardingImage.onBoardingImages.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.height;
    DeviceBarUtils.changeStatusBarColor(Colors.transparent);

    return PageView.builder(
      itemCount: 1000,
      controller: _pageController,
      itemBuilder: (context, position) {
        position = getCurrentIndex(position);
        return Stack(
          alignment: AlignmentDirectional.topStart,
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                AppOnBoardingImage.onBoardingImages[position],
                fit: BoxFit.cover,
              ),
            ),
            isVisible
                ? buildContinueButton(screenSize)
                : buildDotIndicatorWidget(position)
          ],
        );
      },
    );
  }

  Container buildContinueButton(double screenSize) {
    return Container(
      padding: EdgeInsets.only(right: screenSize / 40, bottom: screenSize / 50),
      alignment: AlignmentDirectional.bottomEnd,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppColors.PrimaryColor,
            onPrimary: Colors.white,
          ),
          onPressed: () async {
            addStringToSF();
            bool isAuthenticated =
                await Provider.of<AuthenticationService>(context, listen: false)
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
          child: Text(
            "Continuer",
          )),
    );
  }

  DotIndicatorWidget buildDotIndicatorWidget(int position) {
    return DotIndicatorWidget(
        dotLenght: AppOnBoardingImage.onBoardingImages.length,
        activePageIndex: position,
        dotActiveColor: AppColors.PrimaryColor);
  }
}

class DotIndicatorWidget extends StatefulWidget {
  final dotLenght;
  final activePageIndex;
  final dotActiveColor;
  final dotInactiveColor;
  final height;

  const DotIndicatorWidget(
      {Key key,
      @required this.dotLenght,
      @required this.activePageIndex,
      @required this.dotActiveColor,
      this.dotInactiveColor = Colors.grey,
      this.height = 20})
      : assert(dotLenght != 0),
        assert(activePageIndex != null),
        assert(dotActiveColor != null),
        assert(dotInactiveColor != null),
        assert(height != 0),
        super(key: key);

  @override
  _DotIndicatorWidgetState createState() => _DotIndicatorWidgetState();
}

class _DotIndicatorWidgetState extends State<DotIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.98,
      width: MediaQuery.of(context).size.width,
      alignment: AlignmentDirectional.bottomCenter,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int index = 0; index < widget.dotLenght; index++)
            if (index == widget.activePageIndex) ...[_showIndicator(true)] else
              _showIndicator(false),
        ],
      ),
    );
  }

  Widget _showIndicator(bool isActive) => AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 8),
        height: isActive ? 12 : 8,
        width: isActive ? 12 : 8,
        decoration: BoxDecoration(
            color: isActive ? widget.dotActiveColor : widget.dotInactiveColor,
            borderRadius: BorderRadius.all(Radius.circular(12))),
      );
}
