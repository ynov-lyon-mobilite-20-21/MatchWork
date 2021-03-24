import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/services/storage_manager.dart';
import 'package:match_work/core/utils/device_bar_utils.dart';
import 'package:match_work/ui/widgets/dot_indicator_widget.dart';
import 'package:provider/provider.dart';
import 'home_view.dart';

class OnBoardingView extends StatefulWidget {
  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  List<String> onBoardingImages = AppOnBoardingImages.onBoardingImages;

  PageController _pageController = PageController();
  int currentPage = 0;
  bool isFinalPageReached = false;

  void getChangedPageAndMoveBar(int page) {
    if (page >= onBoardingImages.length) {
      page = page % onBoardingImages.length;
      isFinalPageReached = true;
    }

    currentPage = page;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    DeviceBarUtils.showStatusBar(false);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
                controller: _pageController,
                onPageChanged: (page) => getChangedPageAndMoveBar(page),
                itemBuilder: (context, position) {
                  return Container(
                    child: Image.asset(
                      onBoardingImages[currentPage],
                      fit: BoxFit.fill,
                    ),
                  );
                })),
        onBoardingImages.last == onBoardingImages[currentPage] ||
                isFinalPageReached
            ? showContinueButton(context)
            : showDotIndicator(context)
      ],
    );
  }

  DotIndicatorWidget showDotIndicator(BuildContext context) {
    return DotIndicatorWidget(
      dotLenght: onBoardingImages.length,
      activePageIndex: currentPage,
      dotActiveColor: AppColors.AccentColor,
      dotInactiveColor: Colors.grey,
    );
  }

  Container showContinueButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 30),
      alignment: AlignmentDirectional.bottomEnd,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FlatButton(
            color: AppColors.PrimaryColor,
            child: Text("Continuer",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white, fontSize: 12)),
            onPressed: () async {
              StorageManager.saveData("isFirstLaunch", false);
              bool isAuthenticated = await Provider.of<AuthenticationService>(
                      context,
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
          ),
        ],
      ),
    );
  }
}
