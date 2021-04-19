import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_work/core/enums/gender.dart';
import 'package:match_work/core/models/skill.dart';
import 'package:match_work/core/repositories/user_repository.dart';
import 'package:match_work/core/utils/date_utils.dart';

import 'experience.dart';
import 'formation.dart';

class User {
  String uid;
  String firstName;
  String lastName;
  String pictureUrl;
  String phoneNumber;
  String mail;
  Timestamp birthday;
  String bio;
  String status;
  Gender gender;
  List<Skill> skills;
  List<Formation> formations;
  List<Experience> experiences;

  User(
      {this.uid,
      this.firstName,
      this.lastName,
      this.mail,
      this.phoneNumber,
      this.pictureUrl,
      this.birthday,
      this.bio,
      this.status,
      this.gender});

  String displayName() {
    String lastName =
        this.lastName.isNotEmpty ? this.lastName.trim().toUpperCase() : '';
    String firstName = this.firstName.trim().isNotEmpty
        ? this.firstName[0].toUpperCase() +
            this.firstName.substring(1).toLowerCase()
        : '';
    return lastName + (lastName.isNotEmpty ? ' ' : '') + firstName;
  }

  User.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot.id,
        phoneNumber =
            snapshot.data()[UserRepository.phoneNumberReference] ?? '',
        mail = snapshot.data()[UserRepository.mailReference] ?? '',
        lastName = snapshot.data()[UserRepository.lastNameReference] ?? '',
        firstName = snapshot.data()[UserRepository.firstNameReference] ?? '',
        pictureUrl = snapshot.data()[UserRepository.pictureUrlReference],
        birthday = snapshot.data()[UserRepository.birthdayReference],
        bio = snapshot.data()[UserRepository.bioReference] ?? '',
        status = snapshot.data()[UserRepository.statusReference] ?? '',
        gender = snapshot.data()[UserRepository.genderReference] != null
            ? (snapshot.data()[UserRepository.genderReference] ==
                    Gender.Woman.toString()
                ? Gender.Woman
                : Gender.Man)
            : null;

  Map<String, dynamic> toJson() => {
        UserRepository.mailReference: mail,
        UserRepository.firstNameReference: firstName,
        UserRepository.lastNameReference: lastName,
        UserRepository.pictureUrlReference: pictureUrl,
        UserRepository.phoneNumberReference: phoneNumber,
        UserRepository.birthdayReference: birthday,
        UserRepository.bioReference: bio,
        UserRepository.statusReference: status,
        UserRepository.genderReference: gender.toString()
      };

  int getAge() => this.birthday != null
      ? DateUtils.calculateAge(this.birthday.toDate())
      : null;

  void sortFormations() {
    if (this.formations != null) {
      this.formations.sort((a, b) {
        DateTime aDate = DateUtils.getDateFromString(a.startDate);
        DateTime bDate = DateUtils.getDateFromString(b.startDate);
        if (aDate == null) {
          return -1;
        }
        if (bDate == null) {
          return 1;
        }
        if (aDate.isBefore(bDate)) {
          return -1;
        }
        if (aDate.isAfter(bDate)) {
          return 1;
        }
        return 0;
      });
    }
  }

  void sortExperiences() {
    if (this.experiences != null) {
      this.experiences.sort((a, b) {
        DateTime aDate = DateUtils.getDateFromString(a.startDate);
        DateTime bDate = DateUtils.getDateFromString(b.startDate);
        if (aDate == null) {
          return -1;
        }
        if (bDate == null) {
          return 1;
        }
        if (aDate.isBefore(bDate)) {
          return -1;
        }
        if (aDate.isAfter(bDate)) {
          return 1;
        }
        return 0;
      });
    }
  }
}
