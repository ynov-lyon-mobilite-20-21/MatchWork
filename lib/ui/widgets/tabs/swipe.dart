import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/viewmodels/widgets/tabs/swipe_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/widgets/loaderWidget.dart';
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
        builder: (context, model, widget) => StreamBuilder(
            stream: model.outUsers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<User> users = snapshot.data;
                return Center(
                    child: Column(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: TinderSwapCard(
                        swipeDown: false,
                        swipeUp: false,
                        orientation: AmassOrientation.TOP,
                        totalNum: users.length,
                        stackNum: 2,
                        swipeEdge: 1.0,
                        maxWidth: MediaQuery.of(context).size.width * 0.91,
                        maxHeight: MediaQuery.of(context).size.height * 0.62,
                        minWidth: MediaQuery.of(context).size.width * 0.90,
                        minHeight: MediaQuery.of(context).size.height * 0.61,
                        cardBuilder: (context, index) {
                          User currentUser = users[index];
                          List<Widget> listSkills = [];
                          currentUser.skills.forEach((skill) {
                            Widget skillWidget = Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: SkillButton(
                                  color: theme.primaryColor,
                                  text: skill.label,
                                  style: theme.textTheme.bodyText2),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child: currentUser.pictureUrl != null &&
                                                currentUser
                                                    .pictureUrl.isNotEmpty
                                            ? Image.network(
                                                currentUser.pictureUrl,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.43,
                                              )
                                            : Image.asset(
                                                AppLogoImages.LogoMatchWorkBlue,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.43,
                                              )),
                                    Text(
                                      currentUser.displayName(),
                                      style: theme.textTheme.headline4,
                                    ),
                                    Text("", style: theme.textTheme.bodyText2),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.02,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.transparent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Wrap(
                                            children: listSkills,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            back: Container(
                              decoration: BoxDecoration(
                                color: theme.cardColor,
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
                                                  color: theme.cardColor),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          child: Text(currentUser.bio ?? "",
                                              style: theme.textTheme.bodyText2),
                                        ),
                                        Container(
                                          height: 20.0,
                                          width: 20.0,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.83,
                                          height: 1,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: theme.accentColor),
                                          ),
                                        ),
                                        Container(
                                          height: 20.0,
                                          width: 20.0,
                                        ),
                                        InputDecorator(
                                          decoration: InputDecoration(
                                            labelText: 'Experience',
                                            labelStyle: TextStyle(
                                              color: theme.accentColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: theme.cardColor),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          child: Text(
                                            currentUser.bio ?? "",
                                          ),
                                        ),
                                        Container(
                                          height: 20.0,
                                          width: 20.0,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.83,
                                          height: 1,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: theme.accentColor),
                                          ),
                                        ),
                                        Container(
                                          height: 20.0,
                                          width: 20.0,
                                        ),
                                        InputDecorator(
                                          decoration: InputDecoration(
                                            labelText: 'Parcours',
                                            labelStyle: TextStyle(
                                              color: theme.accentColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: theme.cardColor),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          child: Text(
                                            currentUser.bio ?? "",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        cardController: model.controller,
                        swipeCompleteCallback:
                            (CardSwipeOrientation orientation, int index) {
                          User userSelected = users[index];
                          if (orientation.index == 0) {
                            //LEFT
                          } else {
                            //RIGHT
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RawMaterialButton(
                          onPressed: () {
                            model.controller.triggerLeft();
                          },
                          elevation: 2.0,
                          fillColor: Colors.white,
                          child: Image.asset(
                            AppIcons.Croix,
                            width: 25,
                            height: 25,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            model.controller.triggerRight();
                          },
                          elevation: 2.0,
                          fillColor: Colors.white,
                          child: Image.asset(
                            AppIcons.Coeur,
                            width: 25,
                            height: 25,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        )
                      ],
                    )
                  ],
                ));
              }
              return LoaderWidget();
            }));
  }
}

class SkillButton extends StatefulWidget {
  final color;
  final String text;
  final style;

  const SkillButton(
      {Key key,
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
    var theme = Provider.of<ThemeProvider>(context).getTheme();
    return ButtonTheme(
      minWidth: 65.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            side: BorderSide(color: theme.textTheme.caption.color)),
        color: theme.textTheme.caption.color,
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
