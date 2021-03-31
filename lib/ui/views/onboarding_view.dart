import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/utils/device_bar_utils.dart';

class OnBoardingView extends StatelessWidget {
  final List<String> onBoardingImages = AppOnBoardingImage.onBoardingImages;
  @override
  Widget build(BuildContext context) {
    DeviceBarUtils.changeStatusBarColor(Colors.transparent);
    return PageView.builder(
      itemCount: onBoardingImages.length,
      itemBuilder: (context, position) {
        Color color;
        if (position % 3 == 0) {
          color = Colors.red;
        } else if (position % 3 == 1) {
          color = Colors.blue;
        } else {
          color = Colors.green;
        }

        return Container(
          child: Image.asset(
            AppOnBoardingImage.onBoardingImages[position],
            fit: BoxFit.fill,
          ),
        );
      },
    );
  }
}

// class OnBoardingView extends StatefulWidget {
//   @override
//   _OnBoardingViewState createState() => _OnBoardingViewState();
// }

// class _OnBoardingViewState extends State<OnBoardingView> {
//   @override
//   Widget build(BuildContext context) {
//     DeviceBarUtils.changeStatusBarColor(Colors.transparent);

//     final double height = MediaQuery.of(context).size.height;

//     return Container(
//       child: Stack(
//         children: <Widget>[
//           CarouselSlider(
//             options: CarouselOptions(
//                 height: height,
//                 viewportFraction: 1.0,
//                 enableInfiniteScroll: true,
//                 enlargeCenterPage: false,
//                 onPageChanged: (index, reason) {
//                   setState(() {});
//                 }),
//             items: imgList
//                 .map((image) => Container(
//                       height: height * 1.255,
//                       child: Container(
//                           child: Stack(children: [
//                         Image.asset(image,
//                             fit: BoxFit.cover, height: height * 1.255),
//                         Container(
//                           child: CarouselButtonWidget(
//                               images: imgList, currentImage: image),
//                         )
//                       ])),
//                     ))
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CarouselButtonWidget extends StatefulWidget {
//   final List<String> images;
//   final String currentImage;

//   const CarouselButtonWidget({Key key, this.images, this.currentImage})
//       : super(key: key);

//   @override
//   _CarouselButtonWidgetState createState() => _CarouselButtonWidgetState();
// }

// class _CarouselButtonWidgetState extends State<CarouselButtonWidget> {
//   static bool isVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     var lastImage = widget.images.last;
//     var _current = widget.images.indexOf(widget.currentImage);
//     final double height = MediaQuery.of(context).size.height;

//     if (_current == widget.images.indexOf(lastImage) || isVisible) {
//       isVisible = true;
//       return Container(
//         padding: EdgeInsets.only(left: height * 0.35, top: height * 0.93),
//         child: FlatButton(
//             color: AppColors.PrimaryColor,
//             height: height * 0.056,
//             onPressed: () async {
//               bool isAuthenticated = await Provider.of<AuthenticationService>(
//                       context,
//                       listen: false)
//                   .isUserLoggedIn();
//               if (isAuthenticated) {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (BuildContext context) => HomeView()));
//               } else {
//                 Navigator.pushNamed(context, RoutePath.Start);
//               }
//             },
//             child: Text("Continuer",
//                 style: TextStyle(fontSize: 20, color: Colors.white))),
//       );
//     } else {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: imgList.map((url) {
//           int index = imgList.indexOf(url);
//           return Container(
//             width: height * 0.033,
//             height: height * 0.016,
//             margin: EdgeInsets.only(top: height * 0.96),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: _current == index ? Colors.white : AppColors.AccentColor,
//             ),
//           );
//         }).toList(),
//       );
//     }
//   }
// }
