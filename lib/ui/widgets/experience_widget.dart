import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/models/experience.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ExperienceWidget extends StatefulWidget {
  final Experience experience;
  final Function onDelete;

  ExperienceWidget({@required this.experience, this.onDelete});

  @override
  _ExperienceWidgetState createState() => _ExperienceWidgetState();
}

class _ExperienceWidgetState extends State<ExperienceWidget> {
  @override
  Widget build(BuildContext context) {
    Experience experience = widget.experience;
    Function onDelete = widget.onDelete;
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(right: 20),
            child: ListTile(
              title: Text(
                "${experience.job} : ${experience.company} ${experience.startDate}${experience.endDate != null ? ' - ' + experience.endDate : ''}",
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              subtitle: Text(
                experience.description ?? '',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              trailing: onDelete != null
                  ? InkWell(
                      onTap: () {
                        onDelete();
                      },
                      child: Image.asset(
                        AppIcons.Delete,
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                    )
                  : null,
              contentPadding: EdgeInsets.only(left: 20),
            )),
        Container(
          height: 1.0,
          width: MediaQuery.of(context).size.width * 0.80,
          color: isDarkMode ? Colors.white : Colors.black,
        )
      ],
    );
  }
}
