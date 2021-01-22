import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:getwidget/getwidget.dart';
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
        builder: (context, model, widget) => model.index == 1
            ? Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: FlipCard(
                    key: Key('_index'),
                    front: TinderSwapCard(
                      swipeDown: false,
                      swipeUp: false,
                      orientation: AmassOrientation.TOP,
                      totalNum: 5,
                      stackNum: 3,
                      maxWidth: MediaQuery.of(context).size.width * 0.91,
                      maxHeight: MediaQuery.of(context).size.width * 1.21,
                      minWidth: MediaQuery.of(context).size.width * 0.9,
                      minHeight: MediaQuery.of(context).size.width * 1.2,
                      cardBuilder: (context, index) => Card(
                        color: theme.primaryColorDark,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                model.tinderimages[index],
                                fit: BoxFit.fill,
                              ),
                              Text(
                                model.tindername[index],
                                style: theme.textTheme.headline2,
                              ),
                              Text(model.tinderage[index], style:theme.textTheme.bodyText1),
                              Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.02,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.18,
                                width: MediaQuery.of(context).size.width * 0.90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: theme.accentColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.only(left: 2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GFButton(
                                      onPressed: () {},
                                      text: model.tinderspe[index],
                                      shape: GFButtonShape.pills,
                                      color: theme.primaryColor,
                                      size: GFSize.SMALL,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        elevation: 10.0,
                      ),
                      swipeUpdateCallback:
                          (DragUpdateDetails details, Alignment align) {
                        if (align.x < 0) {
                        } else if (align.x > 0) {
                          //Card is RIGHT swiping
                        }
                      },
                    ),
                    back: TinderSwapCard(
                      swipeDown: false,
                      swipeUp: false,
                      orientation: AmassOrientation.TOP,
                      totalNum: 5,
                      stackNum: 3,
                      maxWidth: MediaQuery.of(context).size.width * 0.91,
                      maxHeight: MediaQuery.of(context).size.width * 1.21,
                      minWidth: MediaQuery.of(context).size.width * 0.9,
                      minHeight: MediaQuery.of(context).size.width * 1.2,
                      cardBuilder: (context, index) => Card(
                        color: theme.primaryColorDark,
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
                                        borderSide:
                                            new BorderSide(color: theme.accentColor),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Text(
                                        "Denique Antiochensis ordinis vertices sub uno elogio iussit occidi ideo efferatus, quod vertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quod ei celebrari vilitatem intempestivam urgenti, cum inpenderet inopia, gravius rationabili responderunt; et perissent ad unum."),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.07,
                                  ),
                                  InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Experience',
                                      labelStyle: TextStyle(
                                        color: theme.accentColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: theme.accentColor),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Text(
                                        "Denique Antiochensis ordinis vertices sub uno elogio iussit occidi ideo efferatus, quod vertices sub uno elogio iussit occidi ideo efferatus, m urgenti, cum inpenderet inopia, gr"),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.07,
                                  ),
                                  InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Parcours',
                                      labelStyle: TextStyle(
                                        color: theme.accentColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: theme.accentColor),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Text(""),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        elevation: 10.0,
                      ),
                      swipeUpdateCallback:
                          (DragUpdateDetails details, Alignment align) {
                        if (align.x < 0) {
                        } else if (align.x > 0) {
                          //Card is RIGHT swiping
                        }
                      },
                    ),
                  ),
                ),
              )
            : SizedBox.expand(child: FlutterLogo()));
  }
}
