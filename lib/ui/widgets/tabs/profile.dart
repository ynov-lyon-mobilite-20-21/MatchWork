import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/constants/app_constants.dart';
import 'package:match_work/core/viewmodels/widgets/tabs/profile_model.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:match_work/ui/views/base_widget.dart';
import 'package:match_work/ui/widgets/experience_widget.dart';
import 'package:match_work/ui/widgets/formation_widget.dart';
import 'package:match_work/ui/widgets/loader_widget.dart';
import 'package:match_work/ui/widgets/profile_picture_widget.dart';
import 'package:match_work/ui/widgets/skill_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../app_bar_widget.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Provider.of<ThemeProvider>(context).getTheme();
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return BaseWidget<ProfileModel>(
      model: ProfileModel(authenticationService: Provider.of(context)),
      onModelReady: (model) => model.listenUserStream(),
      builder: (context, model, widget) => Scaffold(
          appBar: AppBarWidget.showAppBar(
              context: context,
              isVisible: true,
              iconColor: Colors.white,
              color: Color(0xff006E7F)),
          backgroundColor: theme.scaffoldBackgroundColor,
          body: model.user == null
              ? LoaderWidget()
              : SingleChildScrollView(
                  child: Stack(children: <Widget>[
                  Container(
                      child: Column(children: <Widget>[
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: isDarkMode
                                      ? AssetImage(AppImages.ProfilBannerDark)
                                      : AssetImage(AppImages.ProfilBannerLight),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ProfilePictureWidget(
                                    radius: 67.0,
                                    borderThickness: 3.0,
                                    path: model.user.pictureUrl,
                                    backgroundColor:
                                        AppColors.CircleAvatarBorderColor,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    children: [
                                      Text(model.user.displayName(),
                                          style: TextStyle(
                                            fontSize: 22.0,
                                            color: Colors.white,
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      model.user.birthday != null
                                          ? Text("${model.user.getAge()} ans",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                                letterSpacing: 2.0,
                                              ))
                                          : Container(),
                                      SizedBox(
                                        height: 40,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      color: isDarkMode ? Color(0xff00C4C4) : Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.91,
                            child: ListTile(
                              title: Text('Statut\n',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: isDarkMode
                                        ? Color(0xffF7F7F7)
                                        : AppColors.PrimaryColor,
                                  )),
                              subtitle: model.user.status != null &&
                                      model.user.status.trim().isNotEmpty
                                  ? Text(
                                      model.user.status,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        "Aucun statut renseigné",
                                        style: theme.textTheme.caption,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      color: isDarkMode ? Color(0xff0B5C69) : Color(0xffF7F7F7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AppIcons.ProfilGuillemet,
                                height:
                                    MediaQuery.of(context).size.width * 0.18,
                                width: MediaQuery.of(context).size.width * 0.18,
                                alignment: Alignment.topLeft,
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text('Biographie\n',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: isDarkMode
                                            ? Color(0xffF7F7F7)
                                            : AppColors.PrimaryColor,
                                      )),
                                  subtitle: model.user.bio != null &&
                                          model.user.bio.trim().isNotEmpty
                                      ? Text(
                                          model.user.bio,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        )
                                      : Center(
                                          child: Text(
                                            "Aucune biographie renseignée",
                                            style: theme.textTheme.caption,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
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
                          ListTile(
                            title: Text(
                              "Compétence",
                              style: TextStyle(
                                fontSize: 20,
                                color: isDarkMode
                                    ? Color(0xffF7F7F7)
                                    : AppColors.PrimaryColor,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          model.user.skills.length > 0
                              ? Wrap(
                                  children: [
                                    ...model.user.skills.map(
                                        (skill) => SkillWidget(skill: skill))
                                  ],
                                )
                              : Center(
                                  child: Text(
                                    "Aucune compétence renseignée",
                                    style: theme.textTheme.caption,
                                  ),
                                ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //width: MediaQuery.of(context).size.width * 0.91,
                      color: isDarkMode ? Color(0xff0B5C69) : Color(0xffF7F7F7),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.91,
                            child: ListTile(
                              title: Text(
                                'Expérience',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: isDarkMode
                                      ? Color(0xffF7F7F7)
                                      : AppColors.PrimaryColor,
                                ),
                              ),
                            ),
                          ),
                          model.user.experiences.length > 0
                              ? Column(
                                  children: [
                                    ...model.user.experiences.map(
                                        (experience) => ExperienceWidget(
                                            experience: experience))
                                  ],
                                )
                              : Center(
                                  child: Text(
                                    "Aucune expérience renseignée",
                                    style: theme.textTheme.caption,
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width * 0.80,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.91,
                            child: ListTile(
                              title: Text(
                                'Formation',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: isDarkMode
                                      ? Color(0xffF7F7F7)
                                      : AppColors.PrimaryColor,
                                ),
                              ),
                            ),
                          ),
                          model.user.formations.length > 0
                              ? Column(
                                  children: [
                                    ...model.user.formations.map((formation) =>
                                        FormationWidget(formation: formation))
                                  ],
                                )
                              : Center(
                                  child: Text(
                                    "Aucune formation renseignée",
                                    style: theme.textTheme.caption,
                                  ),
                                ),
                          SizedBox(
                            height: 20.0,
                          )
                        ],
                      ),
                    ),
                  ])),
                ]))),
    );
  }
}
