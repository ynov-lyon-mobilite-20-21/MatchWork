import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';

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
      backgroundColor: backgroundColor == null
          ? Theme.of(context).indicatorColor
          : backgroundColor,
      child: CircleAvatar(
        backgroundImage: path == null || path.isEmpty
            ? AssetImage(AppImages.UnknownUser)
            : NetworkImage(path),
        backgroundColor: Colors.grey,
        radius: radius - 5.0,
      ),
    );
  }
}
