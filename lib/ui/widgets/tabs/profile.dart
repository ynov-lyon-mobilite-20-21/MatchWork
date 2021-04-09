import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../app_bar_widget.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).getTheme();
    var isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    //var textstyle = TextStyle(color : theme.text)
    return Scaffold(
        appBar: AppBarWidget.showAppBar(
            context: context,
            isVisible: true,
            iconColor: Colors.white,
            color: Color(0xff006E7F)),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Container(
              child: Column(children: <Widget>[
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: isDarkMode
                              ? AssetImage(AppImages.ProfilBannerDark)
                              : AssetImage(AppImages.ProfilBannerLight),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            radius: 70,
                            backgroundColor: AppColors.CircleAvatarBorderColor,
                            child: CircleAvatar(
                              radius: 67,
                              backgroundImage: AssetImage(AppIcons.Settings),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Text("Thomas Noel",
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                    letterSpacing: 2.0,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Text("18 ans",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    letterSpacing: 2.0,
                                  )),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              color: isDarkMode ? Color(0xff00C4C4) : Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.91,
                    child: ListTile(
                      title: Text('Statut\n',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: isDarkMode
                                ? Color(0xffF7F7F7)
                                : AppColors.PrimaryColor,
                          )),
                      subtitle: Text(
                        'qkjsdhqksjdhqisdu',
                        style: TextStyle(
                          fontSize: 15,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              color: isDarkMode ? Color(0xff0B5C69) : Color(0xffF7F7F7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        AppIcons.ProfilGuillemet,
                        height: MediaQuery.of(context).size.width * 0.18,
                        width: MediaQuery.of(context).size.width * 0.18,
                        alignment: Alignment.topLeft,
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text('Biographie',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: isDarkMode
                                    ? Color(0xffF7F7F7)
                                    : AppColors.PrimaryColor,
                              )),
                          subtitle: Text(
                            '\nqskdqhksjdhqksdhqsskjdhqisduhqsidqssduhqssjdhqsjkdjqsuhiduqhsdqihjsxhdqksdhqhsdhqsjkdhgsqhdjhkqshdqsjkhshdqsjkhdgqsjhsdqsjhdh',
                            style: TextStyle(
                              fontSize: 15,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              color: isDarkMode ? Color(0xff006E7F) : Colors.white,
              width: double.infinity,
              padding: EdgeInsets.only(left: 15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    title: Text(
                      "Compétence",
                      style: TextStyle(
                        fontSize: 20,
                        color: isDarkMode
                            ? Color(0xffF7F7F7)
                            : AppColors.PrimaryColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 3.0,
                              color: isDarkMode
                                  ? Color(0xffF7F7F7)
                                  : AppColors.PrimaryColor,
                            )),
                        margin: EdgeInsets.only(right: 15, bottom: 10),
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Compétence",
                              style: TextStyle(
                                color: isDarkMode
                                    ? Color(0xffF7F7F7)
                                    : AppColors.PrimaryColor,
                              ),
                            )),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 3.0,
                                color: isDarkMode
                                    ? Color(0xffF7F7F7)
                                    : AppColors.PrimaryColor,
                              )),
                          margin: EdgeInsets.only(right: 15, bottom: 10),
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Compétence",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Color(0xffF7F7F7)
                                      : AppColors.PrimaryColor,
                                ),
                              ))),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 3.0,
                                color: isDarkMode
                                    ? Color(0xffF7F7F7)
                                    : AppColors.PrimaryColor,
                              )),
                          margin: EdgeInsets.only(right: 15, bottom: 10),
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Compétence",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Color(0xffF7F7F7)
                                      : AppColors.PrimaryColor,
                                ),
                              ))),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 3.0,
                                color: isDarkMode
                                    ? Color(0xffF7F7F7)
                                    : AppColors.PrimaryColor,
                              )),
                          margin: EdgeInsets.only(right: 15, bottom: 10),
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Compétence",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Color(0xffF7F7F7)
                                      : AppColors.PrimaryColor,
                                ),
                              ))),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 3.0,
                                color: isDarkMode
                                    ? Color(0xffF7F7F7)
                                    : AppColors.PrimaryColor,
                              )),
                          margin: EdgeInsets.only(right: 15, bottom: 10),
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Compétence",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Color(0xffF7F7F7)
                                      : AppColors.PrimaryColor,
                                ),
                              ))),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 3.0,
                                color: isDarkMode
                                    ? Color(0xffF7F7F7)
                                    : AppColors.PrimaryColor,
                              )),
                          margin: EdgeInsets.only(right: 15, bottom: 10),
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Compétence",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Color(0xffF7F7F7)
                                      : AppColors.PrimaryColor,
                                ),
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              //width: MediaQuery.of(context).size.width * 0.91,
              color: isDarkMode ? Color(0xff0B5C69) : Color(0xffF7F7F7),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.91,
                    child: ListTile(
                      title: Text(
                        'Expérience',
                        style: TextStyle(
                          fontSize: 20,
                          color: isDarkMode
                              ? Color(0xffF7F7F7)
                              : AppColors.PrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.91,
                    child: ListTile(
                      title: Text(
                        '- \tStage numéro 1 : Entreprise 2017-2020',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '\t\t\tMon travail consist à blablabla',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.91,
                    child: ListTile(
                      title: Text(
                        '- \tStage numéro 2 : Entreprise 2017-2020',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '\t\t\tMon travail consist à blablabla',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.91,
                    child: ListTile(
                      title: Text(
                        '- \tTravail numéro 1 : Entreprise 2017-2020',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '\t\t\tMon travail consist à blablabla',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  //Affiche une ligne
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.80,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.91,
                    child: ListTile(
                      title: Text(
                        'Formation',
                        style: TextStyle(
                          fontSize: 20,
                          color: isDarkMode
                              ? Color(0xffF7F7F7)
                              : AppColors.PrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.91,
                    child: ListTile(
                      title: Text(
                        '- \tStage numéro 1 : Entreprise 2017-2020',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '\t\t\tMon travail consist à blablabla',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.91,
                    child: ListTile(
                      title: Text(
                        '- \tStage numéro 2 : Entreprise 2017-2020',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '\t\t\tMon travail consist à blablabla',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.91,
                    child: ListTile(
                      title: Text(
                        '- \tTravail numéro 1 : Entreprise 2017-2020',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '\t\t\tMon travail consist à blablabla',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])),
        ])));
  }
}
