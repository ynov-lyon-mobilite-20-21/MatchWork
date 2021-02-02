import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';

class ImageLoader {
  List<Image> _images = List<Image>();

  ImageLoader() {
    AppBackgroundImages.appBackgroundImages.forEach((element) {
      _images.add(Image.asset(element));
    });
    AppLogoImages.appIconsLogo.forEach((element) {
      _images.add(Image.asset(element));
    });
    AppImages.appImages.forEach((element) {
      _images.add(Image.asset(element));
    });

    AppIcons.appIcons.forEach((element) {
      _images.add(Image.asset(element));
    });
  }

  void loadImages(BuildContext context) {
    for (var asset in _images) {
      precacheImage(asset.image, context);
    }
  }
}
