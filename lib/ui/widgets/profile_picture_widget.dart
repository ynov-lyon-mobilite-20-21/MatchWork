import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/ui/shared/app_colors.dart';

class ProfilePictureWidget extends StatelessWidget {
  final double radius;
  final String path;
  final Color backgroundColor;

  ProfilePictureWidget(
      {@required this.radius, this.path, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor:
          backgroundColor == null ? PRIMARY_COLOR : backgroundColor,
      child: CircleAvatar(
        backgroundImage:
            AssetImage(path == null ? IMAGES_PATH + '/unknown_user.png' : path),
        backgroundColor: Colors.grey,
        radius: radius - 5.0,
      ),
    );
  }
}
