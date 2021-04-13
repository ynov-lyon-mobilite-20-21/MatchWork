import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/widgets/app_bar_widget.dart';
import 'package:provider/provider.dart';

const SecondaryColor = const Color(0xFFF7F7F7);

class ModificationProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    var theme = Provider.of<ThemeProvider>(context).getTheme();
    return Scaffold(
      appBar: AppBarWidget.showAppBar(
          context: context,
          isVisible: true,
          iconColor: theme.iconTheme.color,
          color: theme.textTheme.headline2.color),



      backgroundColor: SecondaryColor,
      body: SingleChildScrollView(

        child: Container(
            color: isDarkMode?Color(0xff0B5C69):Color(0xffF7F7F7),

            child: Column(children: <Widget>[


              Container(
                color: isDarkMode?Color(0xff006E7F):Colors.white,

                child: Column(
                    children: <Widget>[
                      SizedBox(height: 30,),

                      Center(

                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Color(0xff00C4C4),
                          child: CircleAvatar(
                            radius: 67,
                            //backgroundImage: AssetImage('assets/image/téléchargement.png'),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),

                    ]
                ),
              ),



              Container(
                  color: isDarkMode?Color(0xff0B5C69):Color(0xffF7F7F7),
                  width: MediaQuery.of(context).size.width * 0.91,
                  child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(padding: EdgeInsets.only(right: 10),
                                        child: TextField(
                                          style: TextStyle(
                                            color: isDarkMode?Colors.white:Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            labelStyle: TextStyle(
                                              color: isDarkMode?Colors.white:Colors.black,
                                            ),
                                            //border: OutlineInputBorder(),
                                            labelText: 'Prénom',
                                            isDense: true,
                                            // Added this
                                            // Added this
                                          ),
                                        ),
                                      )
                                  ),
                                  //const Expanded(
                                  //child: Padding(padding: EdgeInsets.only(right: 50))
                                  //),



                                ],
                              ),

                            ],
                          ),

                        ),
                        SizedBox(height: 20,),

                        Container(

                          child: Column(
                            children:[
                              Row(
                                children: [
                                  Expanded(

                                      child: TextField(
                                        style: TextStyle(
                                          color: isDarkMode?Colors.white:Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            color: isDarkMode?Colors.white:Colors.black,
                                          ),
                                          //border: OutlineInputBorder(),
                                          labelText: 'Nom',
                                          isDense: true,                      // Added this
                                          // Added this
                                        ),
                                      )
                                  ),


                                  Expanded(
                                      child: Padding(padding: EdgeInsets.only(left: 100, right: 10),
                                          child: TextField(
                                            style: TextStyle(
                                              color: isDarkMode?Colors.white:Colors.black,
                                            ),
                                            decoration: InputDecoration(
                                              labelStyle:  TextStyle(
                                                color: isDarkMode?Colors.white:Colors.black,
                                              ),
                                              labelText: 'Age',
                                              isDense: true,
                                            ),
                                          )
                                      )

                                  )

                                ],
                              ),
                            ],

                          ),






                        ),
                      ]
                  )
              ),
              SizedBox(height: 20,),

              Container(
                  width: MediaQuery.of(context).size.width * 0.91,
                  child: TextField(
                    style: TextStyle(
                      color: isDarkMode?Colors.white:Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: isDarkMode?Colors.white:Colors.black,
                      ),
                      //border: OutlineInputBorder(),
                      labelText: 'Statut',
                      isDense: true,                      // Added this
                      // Added this
                    ),
                  )
              ),
              SizedBox(height: 20,),

              Container(
                  width: MediaQuery.of(context).size.width * 0.91,
                  child: TextField(
                    style: TextStyle(
                      color: isDarkMode?Colors.white:Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelStyle:  TextStyle(
                        color: isDarkMode?Colors.white:Colors.black,
                      ),
                      //border: OutlineInputBorder(),
                      labelText: 'Description',
                      isDense: true,                      // Added this
                      // Added this
                    ),
                  )
              ),
              SizedBox(height: 20,),

              Container(
                color: isDarkMode?Color(0xff006E7F):Colors.white,
                width: double.infinity,
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text("Compétence",
                              style: TextStyle(
                                color: isDarkMode?Colors.white:Color(0xff006E7F),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),



                        Expanded(
                          child: Padding(padding: EdgeInsets.only(left: 60),
                            child: ListTile(
                              title: Text("Supprimer",
                                style: TextStyle(
                                  color: Colors.red,
                                  height: 0.8,
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),

                        ),


                      ],
                    ),

                    SizedBox(height: 5,),

                    Wrap(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 3.0, color: isDarkMode?Colors.white:Color(0xff006E7F),)),
                            margin: EdgeInsets.only(right: 15, bottom: 10),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Compétence",
                                  style: TextStyle(
                                    color: isDarkMode?Colors.white:Color(0xff006E7F),
                                  )),
                            )),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 3.0, color: isDarkMode?Colors.white:Color(0xff006E7F),)),
                            margin: EdgeInsets.only(right: 15,  bottom: 10),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Compé",
                                  style: TextStyle(
                                    color: isDarkMode?Colors.white:Color(0xff006E7F),
                                  )),
                            )),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 3.0, color: isDarkMode?Colors.white:Color(0xff006E7F),)),
                            margin: EdgeInsets.only(right: 15,  bottom: 10),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Compé",
                                  style: TextStyle(
                                    color: isDarkMode?Colors.white:Color(0xff006E7F),
                                  )),
                            )),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 3.0, color: isDarkMode?Colors.white:Color(0xff006E7F),)),
                            margin: EdgeInsets.only(right: 15,  bottom: 10),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Compétence",
                                  style: TextStyle(
                                    color: isDarkMode?Colors.white:Color(0xff006E7F),
                                  )),
                            )),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 3.0, color: isDarkMode?Colors.white:Color(0xff006E7F),)),
                            margin: EdgeInsets.only(right: 15,  bottom: 10),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Compétence",
                                  style: TextStyle(
                                    color: isDarkMode?Colors.white:Color(0xff006E7F),
                                  )),
                            )),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 3.0, color: isDarkMode?Colors.white:Color(0xff006E7F),)),
                            margin: EdgeInsets.only(right: 15,  bottom: 10),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Compétence",
                                  style: TextStyle(
                                    color: isDarkMode?Colors.white:Color(0xff006E7F),
                                  )),
                            )),

                      ],
                    ),

                    Row(
                      children: [
                        Container(padding: EdgeInsets.only(right: 1),
                            width: 250,
                            child: TextField(
                              style: TextStyle(color: isDarkMode?Colors.white:Colors.black,),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: isDarkMode?Colors.white:Colors.black,),
                                //border: OutlineInputBorder(),
                                labelText: 'entrez une compétence',
                                isDense: true,                      // Added this
                                // Added this
                              ),


                            )),

                        Container(padding: EdgeInsets.only(left: 20, right: 10),
                          child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xff00C4C4)),
                            ),


                            onPressed: () {

                            },
                            child: Text('Ajouter',
                                style: TextStyle(
                                    color: Colors.white
                                )),
                          ),

                        )


                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                  ],
                ),
              ),


              SizedBox(height: 10,),

              Container(
                width: MediaQuery.of(context).size.width * 0.91,
                child: Column(
                    children: [
                      ListTile(
                        title: Text('Expérience',
                          style: TextStyle(
                            fontSize: 20,
                            color: isDarkMode?Colors.white:Color(0xff006E7F),

                          ),

                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.91,
                        color: isDarkMode?Color(0xff006E7F):Colors.white,
                        child: Column(
                            children: [


                              Padding(padding: EdgeInsets.only(right: 20),
                                  child: ListTile(title: Text("Titre expérience",
                                    style: TextStyle(
                                      color: isDarkMode?Colors.white:Colors.black,
                                    ),),
                                    subtitle: Text("description",
                                      style: TextStyle(
                                        color: isDarkMode?Colors.white:Colors.black,
                                      ),),
                                    trailing: Image.asset(AppIcons.Delete, width: MediaQuery.of(context).size.width * 0.1,),
                                    contentPadding: EdgeInsets.only(left: 20),
                                  )
                              ),

                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width * 0.80,
                                color: isDarkMode?Colors.white:Colors.black,
                              ),




                              Padding(padding: EdgeInsets.only(right: 20),
                                  child: ListTile(title: Text("Titre expérience",
                                    style: TextStyle(
                                      color: isDarkMode?Colors.white:Colors.black,
                                    ),),
                                    subtitle: Text("description",
                                      style: TextStyle(
                                        color: isDarkMode?Colors.white:Colors.black,
                                      ),),
                                    trailing: Image.asset(AppIcons.Delete, width: MediaQuery.of(context).size.width * 0.1,),
                                    contentPadding: EdgeInsets.only(left: 20),
                                  )
                              ),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width * 0.80,
                                color: isDarkMode?Colors.white:Colors.black,
                              ),

                              Padding(padding: EdgeInsets.only(right: 20),
                                  child: ListTile(title: Text("Titre expérience",
                                    style: TextStyle(
                                      color: isDarkMode?Colors.white:Colors.black,
                                    ),),
                                    subtitle: Text("description",
                                      style: TextStyle(
                                        color: isDarkMode?Colors.white:Colors.black,
                                      ),),
                                    trailing: Image.asset(AppIcons.Delete, width: MediaQuery.of(context).size.width * 0.1,),
                                    contentPadding: EdgeInsets.only(left: 20),
                                  )
                              ),





                            ]
                        ),
                      ),
                      ListTile(
                        title: Text('Ajouter une expérience',
                          style: TextStyle(
                            color: isDarkMode?Colors.white:Color(0xff006E7F),
                          ),

                        ),
                      ),
                      TextField(
                        style: TextStyle(
                          color: isDarkMode?Colors.white:Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: isDarkMode?Colors.white:Colors.black,
                          ),
                          //border: OutlineInputBorder(),
                          labelText: 'Titre',
                          isDense: true,                      // Added this
                          // Added this
                        ),
                      ),
                      TextField(
                        style: TextStyle(
                          color: isDarkMode?Colors.white:Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: isDarkMode?Colors.white:Colors.black,
                          ),
                          //border: OutlineInputBorder(),
                          labelText: 'Description',
                          isDense: true,                      // Added this
                          // Added this
                        ),
                      ),

                      SizedBox(height: 20,),

                      ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xff00C4C4)),
                        ),
                        onPressed: () {

                        },
                        child: Text('Ajouter',
                          style: TextStyle(
                              color: Colors.white
                          ),),

                      ),

                      SizedBox(height: 30,),

                      ListTile(
                        title: Text('Formation',
                          style: TextStyle(
                            fontSize: 20,
                            color: isDarkMode?Colors.white:Color(0xff006E7F),

                          ),

                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.91,
                        color: isDarkMode?Color(0xff006E7F):Colors.white,
                        child: Column(
                            children: [
                              Padding(padding: EdgeInsets.only(right: 20),
                                  child: ListTile(title: Text("Titre formation",
                                    style: TextStyle(
                                      color: isDarkMode?Colors.white:Colors.black,
                                    ),),
                                    subtitle: Text("description",
                                      style: TextStyle(
                                        color: isDarkMode?Colors.white:Colors.black,
                                      ),),
                                    trailing: Image.asset(AppIcons.Delete, width: MediaQuery.of(context).size.width * 0.1,),
                                    contentPadding: EdgeInsets.only(left: 20),
                                  )
                              ),

                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width * 0.80,
                                color: isDarkMode?Colors.white:Colors.black,
                              ),

                              Padding(padding: EdgeInsets.only(right: 20),
                                  child: ListTile(title: Text("Titre formation",
                                    style: TextStyle(
                                      color: isDarkMode?Colors.white:Colors.black,
                                    ),),
                                    subtitle: Text("description",
                                      style: TextStyle(
                                        color: isDarkMode?Colors.white:Colors.black,
                                      ),),
                                    trailing: Image.asset(AppIcons.Delete, width: MediaQuery.of(context).size.width * 0.1,),
                                    contentPadding: EdgeInsets.only(left: 20),
                                  )
                              ),

                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width * 0.80,
                                color: isDarkMode?Colors.white:Colors.black,
                              ),

                              Padding(padding: EdgeInsets.only(right: 20),
                                  child: ListTile(title: Text("Titre formation",
                                    style: TextStyle(
                                      color: isDarkMode?Colors.white:Colors.black,
                                    ),),
                                    subtitle: Text("description",
                                      style: TextStyle(
                                        color: isDarkMode?Colors.white:Colors.black,
                                      ),),
                                    trailing: Image.asset(AppIcons.Delete, width: MediaQuery.of(context).size.width * 0.1,),
                                    contentPadding: EdgeInsets.only(left: 20),
                                  )
                              ),



                            ]
                        ),
                      ),
                      ListTile(
                        title: Text('Ajouter une formation',
                          style: TextStyle(
                            color: isDarkMode?Colors.white:Color(0xff006E7F),
                          ),

                        ),
                      ),
                      TextField(
                        style: TextStyle(
                          color: isDarkMode?Colors.white:Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: isDarkMode?Colors.white:Colors.black,
                          ),
                          //border: OutlineInputBorder(),
                          labelText: 'Titre',
                          isDense: true,                      // Added this
                          // Added this
                        ),
                      ),
                      TextField(
                        style: TextStyle(
                          color: isDarkMode?Colors.white:Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: isDarkMode?Colors.white:Colors.black,
                          ),
                          //border: OutlineInputBorder(),
                          labelText: 'Description',
                          isDense: true,                      // Added this
                          // Added this
                        ),
                      ),

                      SizedBox(height: 30,),

                      ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xff00C4C4)),
                        ),
                        onPressed: () {

                        },
                        child: Text('Ajouter',
                          style: TextStyle(
                              color: Colors.white
                          ),),
                      ),
                      SizedBox(height: 30,),
                      Container(

                          child: Column(
                              children:[
                                Row(
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red, // background
                                          onPrimary: Colors.white,

                                        ),
                                        onPressed: () {

                                        },
                                        child: Text('Annuler'),
                                      ),
                                      Padding(padding: EdgeInsets.only(left: 20),
                                        child: ElevatedButton(
                                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xff00C4C4)),
                                          ),
                                          onPressed: () {

                                          },
                                          child: Text('Enregistrer les modifications',
                                            style: TextStyle(
                                                color: Colors.white
                                            ),),
                                        ),
                                      ),
                                    ]
                                )
                              ]
                          )
                      ),
                      SizedBox(height: 30,),




                    ]
                ),
              ),





            ],
            )
        ),
      ),
    );
  }
}