import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';

import 'home_view.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class TutorialView extends StatefulWidget {
  @override
  _TutorialViewState createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      width: 150.0,
      height: 150.0,
      child: Stack(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
                height: height,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: imageTest,
          ),

        ],
      ),
    );
  }

  final imageTest = imgList
      .map((image) => Container(
            height: 1000,
            child: Container(
                child: Stack(children: [
              Image.network(image, fit: BoxFit.cover, height: 1000),
              Container(
                child: ButtonTest(images: imgList, currentImage: image),
              )
            ])),
          ))
      .toList();

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            color: Colors.red,
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 500),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'No. ${imgList.indexOf(item)} image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();
}

class ButtonTest extends StatefulWidget {
  final List<String> images;
  final String currentImage;

  const ButtonTest({Key key, this.images, this.currentImage}) : super(key: key);

  @override
  _ButtonTestState createState() => _ButtonTestState();
}

class _ButtonTestState extends State<ButtonTest> {
  @override
  Widget build(BuildContext context) {
    var lastImage = widget.images.last;
    var _current  = widget.images.indexOf(widget.currentImage);

    final double height = MediaQuery.of(context).size.height;
    if (widget.currentImage == lastImage) {
      return Container(
        padding: EdgeInsets.fromLTRB(250, height - 80, 10, 0),
        child: FlatButton(
            color: AppColors.PrimaryColor,
            height: 50,
            onPressed: () {
              /// Si on est arrivé a la fun du carousel on met le bouton partout
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeView()));
            },
            child: Text("Continuer",
                style: TextStyle(fontSize: 20, color: Colors.white))),
      );
    } else {
      return  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.map((url) {
          int index = imgList.indexOf(url);
          return Container(
            width: 20.0,
            height: 10.0,
            margin: EdgeInsets.fromLTRB(0, height - 30, 0, 0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index ? Colors.white : AppColors.AccentColor,
            ),
          );
        }).toList(),
      );
    }
  }
}
