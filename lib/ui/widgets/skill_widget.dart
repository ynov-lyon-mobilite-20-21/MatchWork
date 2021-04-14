import 'package:flutter/material.dart';
import 'package:match_work/core/models/skill.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SkillWidget extends StatefulWidget {
  final Skill skill;
  final Function onDelete;

  SkillWidget({@required this.skill, this.onDelete});

  @override
  _SkillWidgetState createState() => _SkillWidgetState();
}

class _SkillWidgetState extends State<SkillWidget> {
  @override
  Widget build(BuildContext context) {
    Skill skill = widget.skill;
    Function onDelete = widget.onDelete;
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return InkWell(
      onTap: onDelete != null ? () => onDelete() : null,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 3.0,
              color: isDarkMode ? Colors.white : Color(0xff006E7F),
            )),
        margin: EdgeInsets.only(right: 15, bottom: 10),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(skill.label,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Color(0xff006E7F),
                  )),
            ),
            onDelete != null
                ? Align(
                    heightFactor: 1.0,
                    widthFactor: 1.0,
                    child: Icon(
                      Icons.close,
                      size: 13.0,
                      color: isDarkMode ? Colors.white : Color(0xff006E7F),
                    ),
                  )
                : null
          ],
        ),
      ),
    );
  }
}
