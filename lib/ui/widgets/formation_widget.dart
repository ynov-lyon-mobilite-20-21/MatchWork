import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/models/formation.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class FormationWidget extends StatefulWidget {
  final Formation formation;
  final Function onDelete;

  FormationWidget({@required this.formation, this.onDelete});

  @override
  _FormationWidgetState createState() => _FormationWidgetState();
}

class _FormationWidgetState extends State<FormationWidget> {
  @override
  Widget build(BuildContext context) {
    Formation formation = widget.formation;
    Function onDelete = widget.onDelete;

    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Padding(
        padding: EdgeInsets.only(right: 20),
        child: ListTile(
          title: Text(
            "${formation.degree} : ${formation.school} ${formation.startYear} - ${formation.endYear}",
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          subtitle: Text(
            formation.description,
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          trailing: onDelete != null
              ? InkWell(
                  onTap: onDelete(),
                  child: Image.asset(
                    AppIcons.Delete,
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(left: 20),
        ));
  }
}
