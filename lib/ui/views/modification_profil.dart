import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/enums/gender.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/utils/form_validators.dart';
import 'package:match_work/core/viewmodels/views/modification_profil_view_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/widgets/experience_widget.dart';
import 'package:match_work/ui/widgets/formation_widget.dart';
import 'package:match_work/ui/widgets/profile_picture_widget.dart';
import 'package:match_work/ui/widgets/skill_widget.dart';
import 'package:match_work/ui/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class ModificationProfile extends StatefulWidget {
  @override
  _ModificationProfileState createState() => _ModificationProfileState();
}

class _ModificationProfileState extends State<ModificationProfile> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Provider.of<ThemeProvider>(context).getTheme();
    var isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return BaseWidget<ModificationProfileViewModel>(
        model: ModificationProfileViewModel(
            user: Provider.of<AuthenticationService>(context).currentUser),
        onModelReady: (model) async => await model.getCurrentUser(),
        builder: (context, model, widget) => Scaffold(
              appBar: AppBar(
                backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
                iconTheme: theme.iconTheme,
              ),
              backgroundColor: theme.backgroundColor,
              body: SingleChildScrollView(
                child: Container(
                    color: isDarkMode ? Color(0xff0B5C69) : Color(0xffF7F7F7),
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: isDarkMode ? Color(0xff006E7F) : Colors.white,
                          child: Column(children: <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: InkWell(
                                onTap: () async => await model.setPicture(),
                                child: ProfilePictureWidget(
                                  radius: 70.0,
                                  image: model.image,
                                  path: model.user.pictureUrl,
                                  borderThickness: 5.0,
                                  backgroundColor: theme.indicatorColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ]),
                        ),
                        Form(
                          key: model.userFormKey,
                          child: Container(
                              color: isDarkMode
                                  ? Color(0xff0B5C69)
                                  : Color(0xffF7F7F7),
                              width: MediaQuery.of(context).size.width * 0.91,
                              child: Column(children: <Widget>[
                                Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: TextFieldWidget(
                                              label: "Prénom",
                                              controller:
                                                  model.firstNameController,
                                              validation: (value) =>
                                                  FormValidators.isNotEmpty(
                                                      value),
                                            ),
                                          )),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: TextFieldWidget(
                                                label: "Nom",
                                                controller:
                                                    model.nameController,
                                                validation: (value) =>
                                                    FormValidators.isNotEmpty(
                                                        value)),
                                          ))
                                          //const Expanded(
                                          //child: Padding(padding: EdgeInsets.only(right: 50))
                                          //),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20.0),
                                                child: TextFieldWidget(
                                                    label: "Age",
                                                    controller:
                                                        model.ageController,
                                                    inputType:
                                                        TextInputType.number,
                                                    validation: (value) =>
                                                        FormValidators.isAge(
                                                            value)),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Genre: ",
                                                    style: theme
                                                        .textTheme.subtitle2
                                                        .copyWith(
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  Expanded(
                                                    child: genderWidget(
                                                        context: context,
                                                        isSelected:
                                                            model.user.gender ==
                                                                Gender.Woman,
                                                        onTap: () =>
                                                            model.setGender(
                                                                Gender.Woman),
                                                        text: "Mme"),
                                                  ),
                                                  SizedBox(
                                                    width: 8.0,
                                                  ),
                                                  Expanded(
                                                    child: genderWidget(
                                                        context: context,
                                                        isSelected:
                                                            model.user.gender ==
                                                                Gender.Man,
                                                        onTap: () =>
                                                            model.setGender(
                                                                Gender.Man),
                                                        text: "M"),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ])),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.91,
                          child: TextFieldWidget(
                            label: "Statut",
                            controller: model.statusController,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.91,
                            child: TextFieldWidget(
                              label: "Description",
                              controller: model.descriptionController,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          color: isDarkMode ? Color(0xff006E7F) : Colors.white,
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
                                      title: Text(
                                        "Compétences",
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? Colors.white
                                              : Color(0xff006E7F),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Wrap(
                                children: [
                                  ...model.user.skills.map((skill) {
                                    return SkillWidget(
                                      skill: skill,
                                      onDelete: () => model.removeSkill(skill),
                                    );
                                  }),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(right: 1),
                                      width: 250,
                                      child: TextField(
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          //border: OutlineInputBorder(),
                                          labelText: 'entrez une compétence',
                                          isDense: true, // Added this
                                          // Added this
                                        ),
                                      )),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 10),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xff00C4C4)),
                                      ),
                                      onPressed: () {},
                                      child: Text('Ajouter',
                                          style:
                                              TextStyle(color: Colors.white)),
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
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.91,
                          child: Column(children: [
                            ListTile(
                              title: Text(
                                'Expérience',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Color(0xff006E7F),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.91,
                              color:
                                  isDarkMode ? Color(0xff006E7F) : Colors.white,
                              child: Column(children: [
                                ...model.user.experiences
                                    .map((experience) => Column(
                                          children: [
                                            ExperienceWidget(
                                                experience: experience),
                                            Container(
                                              height: 1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.80,
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            )
                                          ],
                                        )),
                              ]),
                            ),
                            ListTile(
                              title: Text(
                                'Ajouter une expérience',
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Color(0xff006E7F),
                                ),
                              ),
                            ),
                            TextField(
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                                //border: OutlineInputBorder(),
                                labelText: 'Titre',
                                isDense: true, // Added this
                                // Added this
                              ),
                            ),
                            TextField(
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                                //border: OutlineInputBorder(),
                                labelText: 'Description',
                                isDense: true, // Added this
                                // Added this
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff00C4C4)),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Ajouter',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ListTile(
                              title: Text(
                                'Formation',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Color(0xff006E7F),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.91,
                              color:
                                  isDarkMode ? Color(0xff006E7F) : Colors.white,
                              child: Column(children: [
                                ...model.user.formations
                                    .map((formation) => Column(
                                          children: [
                                            FormationWidget(
                                                formation: formation),
                                            Container(
                                              height: 1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.80,
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ],
                                        ))
                              ]),
                            ),
                            ListTile(
                              title: Text(
                                'Ajouter une formation',
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Color(0xff006E7F),
                                ),
                              ),
                            ),
                            TextField(
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                                //border: OutlineInputBorder(),
                                labelText: 'Titre',
                                isDense: true, // Added this
                                // Added this
                              ),
                            ),
                            TextField(
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                                //border: OutlineInputBorder(),
                                labelText: 'Description',
                                isDense: true, // Added this
                                // Added this
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff00C4C4)),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Ajouter',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                                child: Column(children: [
                              Row(children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red, // background
                                    onPrimary: Colors.white,
                                  ),
                                  onPressed: () {},
                                  child: Text('Annuler'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xff00C4C4)),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Enregistrer les modifications',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ])
                            ])),
                            SizedBox(
                              height: 30,
                            ),
                          ]),
                        ),
                      ],
                    )),
              ),
            ));
  }
}

Widget genderWidget(
    {@required BuildContext context,
    @required isSelected,
    @required Function onTap,
    @required String text}) {
  ThemeData theme = Provider.of<ThemeProvider>(context).getTheme();
  Color notSelectedTextColor = theme.textTheme.subtitle2.color;

  return InkWell(
    onTap: onTap,
    child: Container(
        height: 40.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isSelected
                ? AppColors.CircleAvatarBorderColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20.0),
            border: isSelected
                ? null
                : Border.all(color: notSelectedTextColor, width: 1.0)),
        child: Text(
          text,
          textScaleFactor: 1.5,
          style: TextStyle(
            color: isSelected ? Colors.white : notSelectedTextColor,
          ),
        )),
  );
}
