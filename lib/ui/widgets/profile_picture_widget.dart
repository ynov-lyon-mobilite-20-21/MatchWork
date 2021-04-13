import 'dart:io';

import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';

class ProfilePictureWidget extends StatelessWidget {
  final double radius;
  final String path;
  final File image;
  final Color backgroundColor;
  final double borderThickness;

  ProfilePictureWidget(
      {@required this.radius,
      this.path,
      this.image,
      this.backgroundColor,
      this.borderThickness = 0.0});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor == null
          ? Theme.of(context).indicatorColor
          : backgroundColor,
      child: CircleAvatar(
        backgroundImage: image != null
            ? FileImage(image)
            : path == null || path.isEmpty
                ? AssetImage(AppImages.UnknownUser)
                : NetworkImage(path),
        backgroundColor: Colors.grey,
        radius: radius - borderThickness,
      ),
    );
  }
}
