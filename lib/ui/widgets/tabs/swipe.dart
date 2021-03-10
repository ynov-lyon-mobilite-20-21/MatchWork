import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/viewmodels/widgets/tabs/swipe_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

class Swipe extends StatefulWidget {
  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    CardController controller;
    var theme = Provider.of<ThemeProvider>(context).getTheme();

    return BaseWidget<SwipeModel>(
        model: SwipeModel(),
        builder: (context, model, widget) => model.index == 1
            ? Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: TinderSwapCard(
                        swipeDown: false,
                        swipeUp: false,
                        orientation: AmassOrientation.TOP,
                        totalNum: 5,
                        stackNum: 3,
                        swipeEdge: 5.0,
                        maxWidth: MediaQuery.of(context).size.width * 0.92,
                        maxHeight: MediaQuery.of(context).size.height * 1.01,
                        minWidth: MediaQuery.of(context).size.width * 0.91,
                        minHeight: MediaQuery.of(context).size.height * 1.0,
                        cardBuilder: (context, index) => FlipCard(
                          direction: FlipDirection.HORIZONTAL,
                          speed: 750,
                          front: Container(
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Align(
                                alignment: Alignment.center,
                                  child : Image.asset(
                                    model.tinderimages[index],
                                    height: MediaQuery.of(context).size.height * 0.40
                                    ,
                                  )),
                                  Divider(
                                      color: theme.textTheme.caption.color
                                  ),
                                  Text(
                                    model.tindername[index],
                                    style: theme.textTheme.headline4,
                                  ),
                                  Text(model.tinderage[index],
                                      style: theme.textTheme.caption),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width * 0.02,
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * 0.15,
                                    width: MediaQuery.of(context).size.width * 0.85,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.only(left: 2.0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Wrap(
                                        spacing: 2.0,
                                        children: <Widget>[
                                          SkillButton(
                                              color: theme.primaryColor,
                                              text: model.tinderspe2[index],
                                              style: theme.textTheme.headline4),
                                          SizedBox(
                                            width:
                                                MediaQuery.of(context).size.width *
                                                    0.02,
                                          ),
                                          if (model.tinderspe2[index] != "")
                                            SkillButton(
                                                color: theme.primaryColor,
                                                text: model.tinderspe2[index],
                                                style: theme.textTheme.headline4),
                                          SizedBox(
                                            width:
                                                MediaQuery.of(context).size.width *
                                                    0.02,
                                          ),
                                          if (model.tinderspe2[index] != "")
                                            SkillButton(
                                                color: theme.primaryColor,
                                                text: model.tinderspe2[index],
                                                style: theme.textTheme.headline4),
                                          SizedBox(
                                            width:
                                                MediaQuery.of(context).size.width *
                                                    0.02,
                                          ),
                                          if (model.tinderspe2[index] != "")
                                            SkillButton(
                                                color: theme.primaryColor,
                                                text: model.tinderspe2[index],
                                                style: theme.textTheme.headline4),
                                          SizedBox(
                                            width:
                                                MediaQuery.of(context).size.width *
                                                    0.02,
                                          ),
                                          if (model.tinderspe2[index] != "")
                                            SkillButton(
                                                color: theme.primaryColor,
                                                text: model.tinderspe2[index],
                                                style: theme.textTheme.headline4),
                                        ],
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
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                                            color: theme.textTheme.headline4.color,
                                              fontWeight: FontWeight.bold
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        child: Text(
                                            "Denique Antiochensis ordinis vertices sub uno elogio iussit occidi ideo efferatus, quod vertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quod ei celebrari vilitatem intempestivam urgenti, cum inpenderet inopia, gravius rationabili responderunt; et perissent ad unum.",
                                            style: theme.textTheme.subtitle2),
                                      ),
                                      Divider(
                                          color: theme.textTheme.headline4.color
                                      ),
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.width *
                                            0.02,
                                      ),
                                      InputDecorator(
                                        decoration: InputDecoration(
                                          labelText: 'Experience',
                                          labelStyle: TextStyle(
                                            color: theme.textTheme.caption.color,
                                            fontWeight: FontWeight.bold
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        child: Text(
                                            "Denique Antiochensis ordinis vertices sub uno elogio iussit occidi ideo efferatus, quod vertices sub uno elogio iussit occidi ideo efferatus, m urgenti, cum inpenderet inopia, gr", style: theme.textTheme.subtitle2,),
                                      ),
                                      Divider(
                                          color: theme.textTheme.caption.color
                                      ),
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.width *
                                            0.02,
                                      ),
                                      InputDecorator(
                                        decoration: InputDecoration(
                                          labelText: 'Parcours',
                                          labelStyle: TextStyle(
                                            color: theme.textTheme.caption.color,
                                              fontWeight: FontWeight.bold
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        child: Text("", style: theme.textTheme.subtitle2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        cardController: controller = CardController(),
                        swipeUpdateCallback:
                            (DragUpdateDetails details, Alignment align) {
                          /// Get swiping card's alignment
                          if (align.x < 0) {
                            log('data:');
                          } else if (align.x > 0) {
                            //Card is RIGHT swiping
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RawMaterialButton(
                          onPressed: () {
                            controller.triggerLeft();
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
                            controller.triggerRight();
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

                ),
              )
            : SizedBox.expand(child: FlutterLogo()));

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
            side: BorderSide(color: theme.textTheme.caption.color)),
        color: theme.cardColor,
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
