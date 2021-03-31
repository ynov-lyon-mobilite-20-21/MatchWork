import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/widgets/profile_picture_widget.dart';
import 'package:provider/provider.dart';

class MatchRequestWidget extends StatefulWidget {
  final User user;
  final Function accept;
  final Function reject;

  MatchRequestWidget(
      {@required this.user, @required this.accept, @required this.reject});

  @override
  _MatchRequestWidgetState createState() => _MatchRequestWidgetState();
}

class _MatchRequestWidgetState extends State<MatchRequestWidget> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Provider.of<ThemeProvider>(context).getTheme();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ProfilePictureWidget(
              radius: 20.0,
              path: widget.user.pictureUrl,
              borderThickness: 3.0,
              backgroundColor: theme.indicatorColor,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(widget.user.displayName(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.headline4
                    .copyWith(fontWeight: FontWeight.normal))
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () => widget.accept,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.CircleAvatarBorderColor,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Accepter",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            InkWell(
              onTap: () => widget.reject,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.0, color: theme.textTheme.headline4.color),
                    color: theme.primaryColorLight,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Refuser",
                    style: TextStyle(color: theme.textTheme.headline4.color),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
