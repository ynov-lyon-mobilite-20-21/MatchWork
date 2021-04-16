import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:image_picker/image_picker.dart';
import 'package:match_work/core/enums/gender.dart';
import 'package:match_work/core/models/experience.dart';
import 'package:match_work/core/models/formation.dart';
import 'package:match_work/core/models/skill.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/repositories/user_repository.dart';
import 'package:match_work/core/services/authentication_service.dart';
import 'package:match_work/core/utils/date_utils.dart';
import 'package:match_work/core/utils/storage_utils.dart';
import 'package:match_work/core/viewmodels/base_model.dart';

class ModificationProfileViewModel extends BaseModel {
  User user;
  final AuthenticationService _authenticationService;
  final bool isOldUser;

  File image;
  List<Skill> skillsToAdd = [];
  List<Skill> skillsToRemove = [];
  List<Formation> formationsToAdd = [];
  List<Formation> formationsToRemove = [];
  List<Experience> experiencesToAdd = [];
  List<Experience> experiencesToRemove = [];

  UserRepository _userRepository = UserRepository();

  ImagePicker _imagePicker = ImagePicker();

  final userFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  final skillFormKey = GlobalKey<FormState>();
  TextEditingController skillController = TextEditingController();

  final experienceFormKey = GlobalKey<FormState>();
  TextEditingController jobExperienceController = TextEditingController();
  TextEditingController companyExperienceController = TextEditingController();
  TextEditingController startDateExperienceController = TextEditingController();
  TextEditingController endDateExperienceController = TextEditingController();
  TextEditingController descriptionExperienceController =
      TextEditingController();

  final formationFormKey = GlobalKey<FormState>();
  TextEditingController degreeFormationController = TextEditingController();
  TextEditingController descriptionFormationController =
      TextEditingController();
  TextEditingController schoolFormationController = TextEditingController();
  TextEditingController startDateFormationController = TextEditingController();
  TextEditingController endDateFormationController = TextEditingController();

  ModificationProfileViewModel(
      {@required AuthenticationService authenticationService,
      @required this.isOldUser})
      : _authenticationService = authenticationService;

  Future<void> getCurrentUser() async {
    busy = true;

    this.user = _authenticationService.currentUser;

    user.skills = [];
    user.formations = [];
    user.experiences = [];

    user.skills = await _userRepository.getSkillsByUser(user);
    user.experiences = await _userRepository.getExperiencesByUser(user);
    user.formations = await _userRepository.getFormationsByUser(user);

    user.sortExperiences();
    user.sortFormations();

    firstNameController.text = user.firstName;
    nameController.text = user.lastName;
    birthdayController.text = user.birthday != null
        ? DateUtils.getDateFormat(user.birthday.toDate())
        : '';
    bioController.text = user.bio;
    statusController.text = user.status;

    busy = false;
  }

  Future<bool> editProfile() async {
    busy = true;
    if (userFormKey.currentState.validate()) {
      if (image != null) {
        if (user.pictureUrl != null && user.pictureUrl.trim().isNotEmpty) {
          await StorageUtils.deleteFileFromFirebaseByUrl(
              urlFile: user.pictureUrl);
        }
        user.pictureUrl = await StorageUtils.uploadImageUser(image);
      }

      user.firstName = firstNameController.text.trim();
      user.lastName = nameController.text.trim();
      user.birthday = Timestamp.fromDate(
          DateUtils.getDateFromString(birthdayController.text.trim()));
      user.status = statusController.text.trim();
      user.bio = bioController.text.trim();
      _userRepository.updateUser(user);

      skillsToRemove.forEach((skill) async =>
          await _userRepository.removeSkill(skill: skill, user: user));
      skillsToAdd.forEach((skill) async =>
          await _userRepository.createSkill(skill: skill, user: user));

      experiencesToRemove.forEach((experience) async => await _userRepository
          .removeExperience(experience: experience, user: user));
      experiencesToAdd.forEach((experience) async => await _userRepository
          .createExperience(experience: experience, user: user));

      formationsToRemove.forEach((formation) async => await _userRepository
          .removeFormation(formation: formation, user: user));
      formationsToAdd.forEach((formation) async => await _userRepository
          .createFormation(formation: formation, user: user));

      _authenticationService.updateUser(user);

      return true;
    }
    busy = false;
    return false;
  }

  void removeSkill(Skill skill) {
    busy = true;
    if (skill.id != null) {
      skillsToRemove.add(skill);
    }

    user.skills.remove(skill);
    busy = false;
  }

  void addSkill() async {
    busy = true;
    if (skillFormKey.currentState.validate()) {
      Skill skill = Skill(label: skillController.text.trim());
      skillsToAdd.add(skill);
      user.skills.add(skill);
      skillController.text = "";
    }
    busy = false;
  }

  void removeExperience(Experience experience) {
    busy = true;
    if (experience.id != null) {
      experiencesToRemove.add(experience);
    }
    user.experiences.remove(experience);
    busy = false;
  }

  void addExperience() {
    busy = true;
    if (experienceFormKey.currentState.validate()) {
      Experience experience = Experience(
          job: jobExperienceController.text.trim(),
          company: companyExperienceController.text.trim(),
          description: descriptionExperienceController.text.trim(),
          startDate: startDateExperienceController.text.trim(),
          endDate: endDateExperienceController.text.trim());
      experiencesToAdd.add(experience);
      user.experiences.add(experience);
      user.sortExperiences();

      jobExperienceController.text = '';
      companyExperienceController.text = '';
      descriptionExperienceController.text = '';
      startDateExperienceController.text = '';
      endDateExperienceController.text = '';
    }
    busy = false;
  }

  void removeFormation(Formation formation) {
    busy = true;
    if (formation.id != null) {
      formationsToRemove.add(formation);
    }
    user.formations.remove(formation);
    busy = false;
  }

  void addFormation() {
    busy = true;
    if (formationFormKey.currentState.validate()) {
      Formation formation = Formation(
          degree: degreeFormationController.text.trim(),
          school: schoolFormationController.text.trim(),
          description: descriptionFormationController.text.trim(),
          startDate: startDateFormationController.text.trim(),
          endDate: endDateFormationController.text.trim());

      formationsToAdd.add(formation);
      user.formations.add(formation);
      user.sortFormations();

      degreeFormationController.text = '';
      schoolFormationController.text = '';
      descriptionFormationController.text = '';
      startDateFormationController.text = '';
      endDateFormationController.text = '';
    }
    busy = false;
  }

  Future<void> setPicture() async {
    busy = true;
    PickedFile pickedFile = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    busy = false;
  }

  void setGender(Gender gender) {
    busy = true;
    user.gender = gender;
    busy = false;
  }

  Future<void> selectBirthday(BuildContext context) async {
    busy = true;
    DateTime birthday = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (birthday != null) {
      birthdayController.text = DateUtils.getDateFormat(birthday);
    }

    busy = false;
  }
}
