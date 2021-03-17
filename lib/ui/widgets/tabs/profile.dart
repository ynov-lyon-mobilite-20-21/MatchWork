import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/widgets/app_bar_widget.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).getTheme();

    return Scaffold(
        appBar: AppBarWidget.showAppBar(
            context: context,
            isVisible: true,
            iconColor: theme.iconTheme.color,
            color: theme.textTheme.headline2.color),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.ProfilBannere),
                    fit: BoxFit.cover)),
          ),
          Container(
              child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 90, left: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: AppColors.CircleAvatarBorderColor,
                        child: CircleAvatar(
                          radius: 67,
                          backgroundImage: AssetImage(AppImages.UnknownUser),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30, top: 70),
                        child: Column(
                          children: [
                            Text("Thomas Noel",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: theme.textTheme.bodyText1.color,
                                  letterSpacing: 2.0,
                                )),
                            Text("18 ans",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: theme.textTheme.bodyText1.color,
                                  letterSpacing: 2.0,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.91,
              child: Card(
                color: theme.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text('Emploi\n',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: theme.textTheme.bodyText1.color,
                          )),
                      subtitle: Text(
                        'Statut :',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.1,
            ),
            Text(
              "A propos",
              style: TextStyle(
                fontSize: 16.0,
                color: theme.textTheme.bodyText1.color,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.91,
              child: Card(
                color: theme.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text('Description du profil :',
                          style: theme.textTheme.bodyText1),
                      subtitle: Text(
                        ' ',
                        style: theme.textTheme.bodyText1,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                color: AppColors.PrimaryColor,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text(
                            "\nCompétence\n",
                            style: TextStyle(
                                height: 0.8,
                                fontSize: 16.0,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                      child: Card(
                        color: AppColors.PrimaryColor,
                        shape: RoundedRectangleBorder(
                            side:
                                new BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              title: Text('\n\n\n\n\n'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              "Parcours",
              style: TextStyle(
                fontSize: 16.0,
                color: theme.textTheme.bodyText1.color,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.91,
              child: Card(
                color: theme.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title:
                          Text('Expérience', style: theme.textTheme.headline3),
                    ),
                    ListTile(
                      title: Text(
                        'Titre expérience',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                      subtitle: Text(
                        'Description',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Titre expérience',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                      subtitle: Text(
                        'Description',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Titre expérience',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                      subtitle: Text(
                        'Description',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Titre expérience',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                      subtitle: Text(
                        'Description',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Titre expérience',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                      subtitle: Text(
                        'Description',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                    ),
                    ListTile(
                      title:
                          Text('Formations', style: theme.textTheme.headline3),
                    ),
                    ListTile(
                      title: Text(
                        'Titre expérience',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                      subtitle: Text(
                        'Description',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Titre expérience',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                      subtitle: Text(
                        'Description',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Titre expérience',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                      subtitle: Text(
                        'Description',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Titre expérience',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                      subtitle: Text(
                        'Description',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Titre expérience',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                      subtitle: Text(
                        'Description',
                        style: TextStyle(
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ])),
        ])));
  }
}
