import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:match_work/core/enums/gender.dart';
import 'package:match_work/core/models/skill.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/repositories/user_repository.dart';
import 'package:match_work/core/viewmodels/base_model.dart';

class ModificationProfileViewModel extends BaseModel {
  User user;

  File image;

  UserRepository _userRepository = UserRepository();

  ImagePicker _imagePicker = ImagePicker();

  final userFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  TextEditingController titleExperienceController = TextEditingController();
  TextEditingController descriptionExperienceController =
      TextEditingController();
  TextEditingController titleSchoolController = TextEditingController();
  TextEditingController descriptionSchoolController = TextEditingController();

  ModificationProfileViewModel({@required this.user});

  Future<void> getCurrentUser() async {
    busy = true;

    this.user.skills = await _userRepository.getSkillsByUser(this.user);
    this.user.experiences =
        await _userRepository.getExperiencesByUser(this.user);
    this.user.formations = await _userRepository.getFormationsByUser(this.user);

    this.firstNameController.text = this.user.firstName;
    this.nameController.text = this.user.lastName;
    this.ageController.text = this.user.age.toString();
    this.descriptionController.text = this.user.bio;
    this.statusController.text = this.user.status;

    busy = false;
  }

  void removeSkill(Skill skill) {
    busy = true;
    this.user.skills.remove(skill);
    busy = false;
  }

  Future<void> setPicture() async {
    busy = true;
    PickedFile pickedFile = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    image = File(pickedFile.path);
    busy = false;
  }

  void setGender(Gender gender) {
    busy = true;
    this.user.gender = gender;
    busy = false;
  }

  @override
  void dispose() {
    super.dispose();
    this.user = null;
  }
}
