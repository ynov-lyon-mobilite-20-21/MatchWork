import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/enums/gender.dart';
import 'package:match_work/core/utils/date_utils.dart' as date_utils;
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
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    double width = MediaQuery.of(context).size.width * 0.91;
    return BaseWidget<ModificationProfileViewModel>(
        model: ModificationProfileViewModel(
            authenticationService: Provider.of(context)),
        onModelReady: (model) async => await model.getCurrentUser(),
        builder: (context, model, widget) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Modification du profil",
                  style: TextStyle(color: theme.iconTheme.color),
                ),
                backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
                iconTheme: theme.iconTheme,
                actions: [
                  TextButton(
                      onPressed: () async {
                        bool success = await model.editProfile();
                        if (success) {
                          Navigator.pop(context);
                        }
                      },
                      child: model.busy
                          ? CircularProgressIndicator()
                          : Text(
                              "Enregistrer",
                              style: TextStyle(
                                  color: AppColors.CircleAvatarBorderColor),
                            ))
                ],
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
                              width: width,
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
                                              flex: 3,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20.0),
                                                child: TextFieldWidget(
                                                    label: "Naissance",
                                                    controller: model
                                                        .birthdayController,
                                                    helperText:
                                                        "Format dd/mm/yyyy",
                                                    onTap: () async =>
                                                        await model
                                                            .selectBirthday(
                                                                context),
                                                    validation: (value) =>
                                                        FormValidators.isDate(
                                                            value)),
                                              )),
                                          Expanded(
                                              flex: 5,
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
                          width: width,
                          child: TextFieldWidget(
                            label: "Statut",
                            controller: model.statusController,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: width,
                            child: TextFieldWidget(
                              label: "Bio",
                              controller: model.bioController,
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
                              Form(
                                key: model.skillFormKey,
                                child: Container(
                                  width: width,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFieldWidget(
                                          label: "Entrez une compétence",
                                          controller: model.skillController,
                                          validation: (value) =>
                                              FormValidators.isNotEmpty(value),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color(0xff00C4C4)),
                                        ),
                                        onPressed: () => model.addSkill(),
                                        child: Text('Ajouter',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      )
                                    ],
                                  ),
                                ),
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
                          width: width,
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
                              width: width,
                              color:
                                  isDarkMode ? Color(0xff006E7F) : Colors.white,
                              child: Column(children: [
                                ...model.user.experiences
                                    .map((experience) => Column(
                                          children: [
                                            ExperienceWidget(
                                              experience: experience,
                                              onDelete: () => model
                                                  .removeExperience(experience),
                                            ),
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
                            Form(
                              key: model.experienceFormKey,
                              child: Column(
                                children: [
                                  TextFieldWidget(
                                    label: "Poste",
                                    controller: model.jobExperienceController,
                                    validation: (value) =>
                                        FormValidators.isNotEmpty(value),
                                  ),
                                  TextFieldWidget(
                                    label: "Description",
                                    controller:
                                        model.descriptionExperienceController,
                                    validation: (value) =>
                                        FormValidators.isNotEmpty(value),
                                  ),
                                  TextFieldWidget(
                                    label: "Entreprise",
                                    controller:
                                        model.companyExperienceController,
                                    validation: (value) =>
                                        FormValidators.isNotEmpty(value),
                                  ),
                                  TextFieldWidget(
                                    label: "Date de début",
                                    controller:
                                        model.startDateExperienceController,
                                    inputType: TextInputType.datetime,
                                    helperText:
                                        "Format dd/mm/yyyy ou mm/yyyy ou yyyy",
                                    validation: (value) =>
                                        FormValidators.isDate(value),
                                  ),
                                  TextFieldWidget(
                                    label: "Date de fin",
                                    controller:
                                        model.endDateExperienceController,
                                    inputType: TextInputType.datetime,
                                    helperText:
                                        "Format dd/mm/yyyy ou mm/yyyy ou yyyy",
                                    validation: (value) {
                                      String error =
                                          FormValidators.isDate(value);
                                      if (error == null) {
                                        DateTime dateDebut = date_utils
                                                .DateUtils
                                            .getDateFromString(model
                                                .startDateExperienceController
                                                .text
                                                .trim());
                                        DateTime dateFin = date_utils.DateUtils
                                            .getDateFromString(value.trim());
                                        if (dateDebut != null &&
                                            dateFin != null &&
                                            dateFin.isBefore(dateDebut)) {
                                          error =
                                              "La date de fin doit être supérieure à la date de début";
                                        }
                                      }

                                      return error;
                                    },
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
                                    onPressed: () => model.addExperience(),
                                    child: Text(
                                      'Ajouter',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
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
                              width: width,
                              color:
                                  isDarkMode ? Color(0xff006E7F) : Colors.white,
                              child: Column(children: [
                                ...model.user.formations
                                    .map((formation) => Column(
                                          children: [
                                            FormationWidget(
                                              formation: formation,
                                              onDelete: () => model
                                                  .removeFormation(formation),
                                            ),
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
                            Form(
                                key: model.formationFormKey,
                                child: Column(
                                  children: [
                                    TextFieldWidget(
                                      label: "Diplôme",
                                      controller:
                                          model.degreeFormationController,
                                      validation: (value) =>
                                          FormValidators.isNotEmpty(value),
                                    ),
                                    TextFieldWidget(
                                      label: "Description",
                                      controller:
                                          model.descriptionFormationController,
                                      validation: (value) =>
                                          FormValidators.isNotEmpty(value),
                                    ),
                                    TextFieldWidget(
                                      label: "Ecole",
                                      controller:
                                          model.schoolFormationController,
                                      validation: (value) =>
                                          FormValidators.isNotEmpty(value),
                                    ),
                                    TextFieldWidget(
                                      label: "Date de début",
                                      controller:
                                          model.startDateFormationController,
                                      inputType: TextInputType.datetime,
                                      helperText:
                                          "Format dd/mm/yyyy ou mm/yyyy ou yyyy",
                                      validation: (value) =>
                                          FormValidators.isDate(value),
                                    ),
                                    TextFieldWidget(
                                        label: "Date de fin",
                                        controller:
                                            model.endDateFormationController,
                                        inputType: TextInputType.datetime,
                                        helperText:
                                            "Format dd/mm/yyyy ou mm/yyyy ou yyyy",
                                        validation: (value) {
                                          String error =
                                              FormValidators.isDate(value);
                                          if (error == null) {
                                            DateTime dateDebut = date_utils
                                                    .DateUtils
                                                .getDateFromString(model
                                                    .startDateFormationController
                                                    .text
                                                    .trim());
                                            DateTime dateFin =
                                                date_utils.DateUtils
                                                    .getDateFromString(
                                                        value.trim());
                                            if (dateDebut != null &&
                                                dateFin != null &&
                                                dateFin.isBefore(dateDebut)) {
                                              error =
                                                  "La date de fin doit être supérieure à la date de début";
                                            }
                                          }

                                          return error;
                                        }),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xff00C4C4)),
                                      ),
                                      onPressed: () => model.addFormation(),
                                      child: Text(
                                        'Ajouter',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )),
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
