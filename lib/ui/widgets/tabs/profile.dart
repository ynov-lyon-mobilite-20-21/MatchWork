import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';



class Profile extends StatefulWidget{


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).getTheme();
    //var textstyle = TextStyle(color : theme.text)
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/background/banniere_profil1.png"),
                    fit: BoxFit.cover)),
            child: Container(
                width: double.infinity,
                height: 160,
                alignment: Alignment(-0.95, 7.5),
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Color(0xff00C4C4),
                  child: CircleAvatar(
                    radius: 67,
                    backgroundImage: AssetImage(
                        'assets/images/background/téléchargement.png'),
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(left: 60.0, top: 10),
            child: Text("Thomas Noel",
                style: TextStyle(
                  fontSize: 20.0,
                  color: theme.textTheme.bodyText1.color,
                  letterSpacing: 2.0,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Text("18 ans",
                style: TextStyle(
                  fontSize: 16.0,
                  color: theme.textTheme.bodyText1.color,
                  letterSpacing: 2.0,
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.91,
            child: Card(
              color: theme.scaffoldBackgroundColor,
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
              color: theme.scaffoldBackgroundColor,
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
              color: theme.cardTheme.color,
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
                              height: 0.8, fontSize: 16.0, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: Card(
                      color: Color(0xFF006E81),
                      shape: RoundedRectangleBorder(
                          side: new BorderSide(color: Colors.white, width: 2.0),
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
              color: theme.scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('Expérience',
                        style: TextStyle(
                            color: Color(0xFF008CA6), fontSize: 22.0)),
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
                    title: Text('Formations',
                        style: TextStyle(
                            color: Color(0xFF008CA6), fontSize: 22.0)),
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
        ]))));
  }
}
