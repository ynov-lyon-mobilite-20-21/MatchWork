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
                  child: TinderSwapCard(
                    swipeDown: false,
                    swipeUp: false,
                    orientation: AmassOrientation.TOP,
                    totalNum: 5,
                    stackNum: 3,
                    swipeEdge: 5.0,
                    maxWidth: MediaQuery.of(context).size.width * 0.91,
                    maxHeight: MediaQuery.of(context).size.width * 1.21,
                    minWidth: MediaQuery.of(context).size.width * 0.9,
                    minHeight: MediaQuery.of(context).size.width * 1.2,
                    cardBuilder: (context, index) => FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      speed: 750,
                      front: Container(
                        decoration: BoxDecoration(
                          color: theme.primaryColorDark,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
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
                              Text(model.tinderage[index],
                                  style: theme.textTheme.bodyText1),
                              SizedBox(
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
                                padding: EdgeInsets.all(5.0),
                                child: GridView.count(
                                  // Create a grid with 2 columns. If you change the scrollDirection to
                                  // horizontal, this produces 2 rows.
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 3,
                                  childAspectRatio: ( 0.2 / 0.1),
                                  children: <Widget>[
                                    GFButton(
                                      onPressed: () {},
                                      text: model.tinderspe[index],
                                      shape: GFButtonShape.pills,
                                      color: theme.primaryColor,
                                      size: GFSize.SMALL,
                                      fullWidthButton: true,
                                    ),

                                    if (model.tinderspe2[index] != "")
                                      GFButton(
                                        onPressed: () {},
                                        text: model.tinderspe2[index],
                                        shape: GFButtonShape.pills,
                                        color: theme.primaryColor,
                                        size: GFSize.MEDIUM,
                                      ),

                                    if (model.tinderspe2[index] != "")
                                      GFButton(
                                        onPressed: () {},
                                        text: model.tinderspe2[index],
                                        shape: GFButtonShape.pills,
                                        color: theme.primaryColor,
                                        size: GFSize.MEDIUM,
                                      ),

                                    if (model.tinderspe2[index] != "")
                                      GFButton(
                                        onPressed: () {},
                                        text: model.tinderspe2[index],
                                        shape: GFButtonShape.pills,
                                        color: theme.primaryColor,
                                        size: GFSize.MEDIUM,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      back: Container(
                        decoration: BoxDecoration(
                          color: theme.primaryColorDark,
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
                                        "Denique Antiochensis ordinis vertices sub uno elogio iussit occidi ideo efferatus, quod vertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quodvertices sub uno elogio iussit occidi ideo efferatus, quod ei celebrari vilitatem intempestivam urgenti, cum inpenderet inopia, gravius rationabili responderunt; et perissent ad unum."),
                                  ),
                                  SizedBox(
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
                                        borderSide: new BorderSide(
                                            color: theme.accentColor),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Text(
                                        "Denique Antiochensis ordinis vertices sub uno elogio iussit occidi ideo efferatus, quod vertices sub uno elogio iussit occidi ideo efferatus, m urgenti, cum inpenderet inopia, gr"),
                                  ),
                                  SizedBox(
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
                                        borderSide: new BorderSide(
                                            color: theme.accentColor),
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
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox.expand(child: FlutterLogo()));
  }
}
