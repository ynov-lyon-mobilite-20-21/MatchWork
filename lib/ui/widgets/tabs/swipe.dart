import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/viewmodels/widgets/tabs/swipe_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/widgets/loader_widget.dart';
import 'package:match_work/ui/widgets/tutorial_swipe_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Swipe extends StatefulWidget {
  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> with TickerProviderStateMixin {
  Future<bool> isUserLoggedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool("isFirstLaunchSwipe") ?? true)) {
      var checkValue = await prefs.getBool("isFirstLaunchSwipe");
      return checkValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).getTheme();

    return BaseWidget<SwipeModel>(
        model: SwipeModel(authenticationService: Provider.of(context)),
        onModelReady: (model) => model.listenUsers(),
        builder: (context, model, widget) => StreamBuilder(
            stream: model.outUsers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<User> users = snapshot.data..shuffle();
                users.removeWhere((User user) =>
                    user.uid ==
                    Provider.of<AuthenticationService>(context)
                        .currentUser
                        .uid);
                return users.length == 0
                    ? LoaderWidget()
                    : Stack(
                        children: [
                          Center(
                              child: Column(
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: TinderSwapCard(
                                  swipeDown: false,
                                  swipeUp: false,
                                  orientation: AmassOrientation.TOP,
                                  totalNum: users.length,
                                  stackNum: 2,
                                  swipeEdge: 1.0,
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.91,
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.62,
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.90,
                                  minHeight:
                                      MediaQuery.of(context).size.height * 0.61,
                                  cardBuilder: (context, index) {
                                    User currentUser = users[index];
                                    List<Widget> listSkills = [];
                                    currentUser.skills.forEach((skill) {
                                      Widget skillWidget = Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: SkillButton(
                                            color: theme.primaryColor,
                                            text: skill.label,
                                            style: theme.textTheme.bodyText2),
                                      );
                                      listSkills.add(skillWidget);
                                    });

                                    List<Widget> listExpriences = [];
                                    currentUser.experiences
                                        .forEach((experiences) {
                                      Widget skillWidget2 = Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: ExperiencesZone(
                                          job: experiences.job,
                                          company: experiences.company,
                                          startDate: experiences.startDate,
                                          endDate: experiences.endDate,
                                          description: experiences.description,
                                        ),
                                      );
                                      listExpriences.add(skillWidget2);
                                    });

                                    List<Widget> listFormations = [];
                                    currentUser.formations.forEach((formation) {
                                      Widget skillWidget3 = Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: FormationsZone(
                                          degree: formation.degree,
                                          school: formation.school,
                                          startDate: formation.startDate,
                                          endDate: formation.endDate,
                                          description: formation.description,
                                        ),
                                      );
                                      listFormations.add(skillWidget3);
                                    });

                                    return FlipCard(
                                      direction: FlipDirection.HORIZONTAL,
                                      speed: 750,
                                      front: Container(
                                        decoration: BoxDecoration(
                                          color: theme.cardColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                  alignment: Alignment.center,
                                                  child: currentUser
                                                                  .pictureUrl !=
                                                              null &&
                                                          currentUser.pictureUrl
                                                              .isNotEmpty
                                                      ? Image.network(
                                                          currentUser
                                                              .pictureUrl,
                                                          fit: BoxFit.contain,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.43,
                                                        )
                                                      : Image.asset(
                                                          AppLogoImages
                                                              .LogoMatchWorkBlue,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.43,
                                                        )),
                                              Text(
                                                currentUser.displayName(),
                                                style:
                                                    theme.textTheme.headline4,
                                              ),
                                              Text(
                                                  currentUser.birthday != null
                                                      ? currentUser
                                                              .getAge()
                                                              .toString() +
                                                          " ans"
                                                      : "",
                                                  style: theme
                                                      .textTheme.headline4),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.vertical,
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
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
                                                        color:
                                                            theme.accentColor,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            new BorderSide(
                                                                color: theme
                                                                    .cardColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                    child: Text(
                                                        currentUser.bio ?? "",
                                                        style: theme
                                                            .textTheme.headline5
                                                            .copyWith(
                                                                color: theme
                                                                    .indicatorColor)),
                                                  ),
                                                  Container(
                                                    height: 20.0,
                                                    width: 20.0,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.83,
                                                    height: 1,
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          color: theme
                                                              .accentColor),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 20.0,
                                                    width: 20.0,
                                                  ),
                                                  InputDecorator(
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Experience',
                                                        labelStyle: TextStyle(
                                                          color:
                                                              theme.accentColor,
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: theme
                                                                      .cardColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                      child: Wrap(
                                                        children:
                                                            listExpriences,
                                                      )),
                                                  Container(
                                                    height: 20.0,
                                                    width: 20.0,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.83,
                                                    height: 1,
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          color: theme
                                                              .accentColor),
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
                                                        color:
                                                            theme.accentColor,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            new BorderSide(
                                                                color: theme
                                                                    .cardColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                    child: Wrap(
                                                      children: listFormations,
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
                                      (CardSwipeOrientation orientation,
                                          int index) async {
                                    User userSelected = users[index];
                                    if (orientation.index == 1) {
                                      bool hasConversation = await model
                                          .hasConversation(user: userSelected);
                                      if (hasConversation) {
                                        Navigator.pushNamed(
                                            context, RoutePath.Conversation,
                                            arguments: userSelected);
                                      } else {
                                        await model.matchUser(
                                            user: userSelected);
                                      }
                                    }
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  RawMaterialButton(
                                    onPressed: () {
                                      model.controller.triggerLeft();
                                    },
                                    elevation: 2.0,
                                    fillColor: Colors.white,
                                    child: Image.asset(AppIcons.Croix,
                                        width: 25, height: 25),
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
                          )),
                          FutureBuilder<bool>(
                            future: isUserLoggedin(),
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              if (snapshot.data == false) {
                                return Container();
                              } else {
                                return TutorialSwipeAnimationWidget();
                              }
                            },
                          ),
                        ],
                      );
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
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border.all(color: theme.indicatorColor, width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      child: Text(
        widget.text,
        style: theme.textTheme.bodyText2.copyWith(color: theme.indicatorColor),
      ),
    );
  }
}

class ExperiencesZone extends StatefulWidget {
  final String job;
  final String company;
  final String startDate;
  final String endDate;
  final String description;

  const ExperiencesZone({
    Key key,
    @required this.job,
    @required this.company,
    @required this.startDate,
    @required this.endDate,
    @required this.description,
  }) : super(key: key);

  @override
  ExperiencesZoneState createState() => ExperiencesZoneState();
}

class ExperiencesZoneState extends State<ExperiencesZone> {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).getTheme();
    return Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            border: Border.all(color: theme.indicatorColor, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
        child: ListTile(
          title: Column(
            children: [
              Row(children: [
                Text(widget.job + " - " + widget.company,
                    style: theme.textTheme.headline3
                        .copyWith(color: theme.indicatorColor)),
              ]),
              Row(children: [
                Text(widget.startDate + " - " + widget.endDate,
                    style: theme.textTheme.headline4
                        .copyWith(color: theme.indicatorColor)),
              ]),
              Text(""),
              Row(children: [
                Text(widget.description,
                    style: theme.textTheme.headline5
                        .copyWith(color: theme.indicatorColor))
              ])
            ],
          ),
        ));
  }
}

class FormationsZone extends StatefulWidget {
  final String degree;
  final String school;
  final String startDate;
  final String endDate;
  final String description;

  const FormationsZone({
    Key key,
    @required this.degree,
    @required this.school,
    @required this.startDate,
    @required this.endDate,
    @required this.description,
  }) : super(key: key);

  @override
  FormationsZoneState createState() => FormationsZoneState();
}

class FormationsZoneState extends State<FormationsZone> {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).getTheme();
    return Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            border: Border.all(color: theme.indicatorColor, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
        child: ListTile(
          title: Column(
            children: [
              Row(
                children: [
                  Text(
                    widget.degree + " - " + widget.school,
                    style: theme.textTheme.headline3
                        .copyWith(color: theme.indicatorColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(widget.startDate + " - " + widget.endDate,
                      style: theme.textTheme.headline4
                          .copyWith(color: theme.indicatorColor))
                ],
              ),
              Text(" "),
              Row(children: [
                Text(widget.description,
                    style: theme.textTheme.headline5
                        .copyWith(color: theme.indicatorColor))
              ])
            ],
          ),
        ));
  }
}
