import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/services/storage_manager.dart';
import 'package:provider/provider.dart';


final List<String> imgList = AppCarouselImage.carouselImages;

class TutorialView extends StatefulWidget {
  @override
  _TutorialViewState createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  final imageSliders = imgList
      .map((image) => Container(
            height: 1000,
            child: Container(
                child: Stack(children: [
              Image.asset(image, fit: BoxFit.cover, height: 1000),
              Container(
                child:
                    CarouselButtonWidget(images: imgList, currentImage: image),
              )
            ])),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      width: 150.0,
      height: 150.0,
      child: Stack(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
                height: height,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                  });
                }),
            items: imageSliders,
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

  @override
  Widget build(BuildContext context) {
    var lastImage = widget.images.last;
    var _current = widget.images.indexOf(widget.currentImage);
    final double height = MediaQuery.of(context).size.height;

    if (_current == widget.images.indexOf(lastImage) || isVisible) {
      isVisible = true;
      return Container(
        padding: EdgeInsets.fromLTRB(250, height - 80, 10, 0),
        child: FlatButton(
            color: AppColors.PrimaryColor,
            height: 50,
            onPressed: () async {
              StorageManager.saveData("isFirstLaunch", false);

              bool isAuthenticated =
                  await Provider.of<AuthenticationService>(context, listen: false)
                  .isUserLoggedIn();

              print("Authenticate : $isAuthenticated");
              Navigator.of(context)
                  .pushNamed(isAuthenticated ? RoutePath.Home: RoutePath.Start);
            },
            child: Text("Continuer",
                style: TextStyle(fontSize: 20, color: Colors.white))),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.map((url) {
          int index = imgList.indexOf(url);
          return Container(
            width: 20.0,
            height: 10.0,
            margin: EdgeInsets.fromLTRB(0, height - 30, 0, 0),
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
