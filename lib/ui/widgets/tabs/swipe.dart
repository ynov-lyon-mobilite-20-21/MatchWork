import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:getwidget/getwidget.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/viewmodels/widgets/tabs/swipe_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:provider/provider.dart';

class Swipe extends StatefulWidget {
  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).getTheme();

    return BaseWidget<SwipeModel>(
        model: SwipeModel(),
        onModelReady: (model) => model.listenUsers(),
        builder: (context, model, widget) =>
        model.users.length > 1
            ? Center(
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.7,
            child: TinderSwapCard(
              swipeDown: false,
              swipeUp: false,
              orientation: AmassOrientation.TOP,
              totalNum: model.users.length,
              stackNum: model.users.length,
              swipeEdge: 5.0,
              maxWidth: MediaQuery
                  .of(context)
                  .size
                  .width * 0.91,
              maxHeight: MediaQuery
                  .of(context)
                  .size
                  .width * 1.21,
              minWidth: MediaQuery
                  .of(context)
                  .size
                  .width * 0.9,
              minHeight: MediaQuery
                  .of(context)
                  .size
                  .width * 1.2,
              cardBuilder: (context, index) {
                return StreamBuilder<List<User>>(
                  stream: model.outUsers,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      User currentUser = snapshot.data[index];
                      return FutureBuilder<User>(
                        future: model.getInfosByUser(currentUser),

                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            currentUser = snapshot.data;
                            List<Widget> listSkills = [];
                            currentUser.skills.forEach((skill) {
                              Widget skillWidget = Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: SkillButton(
                                    color: theme.primaryColor,
                                    text: skill.label,
                                    style: theme.textTheme
                                        .bodyText2),

                              );
                              listSkills.add(skillWidget);
                            });
                            return FlipCard(
                              direction: FlipDirection.HORIZONTAL,
                              speed: 750,
                              front: Container(
                                decoration: BoxDecoration(
                                  color: theme.cardColor,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: currentUser.pictureUrl != null && currentUser.pictureUrl.isNotEmpty?Image.network(
                                            currentUser.pictureUrl,
                                            height:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.43,
                                          ):Image.asset(AppLogoImages.LogoMatchWorkBlue,
                                              height:
                                              MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              0.43,)),
                                      Text(
                                        currentUser.displayName(),
                                        style: theme.textTheme.headline4,
                                      ),
                                      Text(
                                          "",
                                          style: theme.textTheme.bodyText2),
                                      SizedBox(
                                        height:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.02,
                                      ),
                                      Container(
                                        height:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.20,
                                        width:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.85,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: theme.accentColor,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              10.0),
                                        ),
                                        padding: EdgeInsets.only(left: 2.0),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Wrap(
                                            children: listSkills,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              back: Container(
                                decoration: BoxDecoration(
                                  color: theme.cardTheme.color,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          InputDecorator(
                                            decoration: InputDecoration(
                                              labelText: 'BIO',
                                              labelStyle: TextStyle(
                                                color: theme.accentColor,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: theme.accentColor),
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            child: Text(
                                                currentUser.bio??"",
                                                style: theme.textTheme
                                                    .bodyText2),
                                          ),
                                          SizedBox(
                                            height:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.07,
                                          ),
                                          InputDecorator(
                                            decoration: InputDecoration(
                                              labelText: 'Experience',
                                              labelStyle: TextStyle(
                                                color: theme.accentColor,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: theme.accentColor),
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            child: Text(
                                              currentUser.bio??"",
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.07,
                                          ),
                                          InputDecorator(
                                            decoration: InputDecoration(
                                              labelText: 'Parcours',
                                              labelStyle: TextStyle(
                                                color: theme.accentColor,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: theme.accentColor),
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            child: Text(currentUser.bio??"",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Center(child: CircularProgressIndicator(),);
                        }
                        ,
                      );
                    }
                    return Center(child: CircularProgressIndicator(),);
                  },
                );
              },
            ),
          ),
        )
            : SizedBox.expand(child: FlutterLogo()));
  }
}

class SkillButton extends StatefulWidget {
  final color;
  final String text;
  final style;

  const SkillButton({Key key,
    @required this.color,
    @required this.text,
    @required this.style})
      : super(key: key);

  @override
  _SkillButtonState createState() => _SkillButtonState();
}

class _SkillButtonState extends State<SkillButton> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 65.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.white)),
        color: widget.color,
        padding: EdgeInsets.all(8.0),
        onPressed: () {},
        child: Text(
          widget.text,
          style: widget.style,
        ),
      ),
    );
  }
}
