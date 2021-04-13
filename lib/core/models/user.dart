import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_work/core/enums/gender.dart';
import 'package:match_work/core/models/skill.dart';
import 'package:match_work/core/repositories/user_repository.dart';

import 'experience.dart';
import 'formation.dart';

class User {
  String uid;
  String firstName;
  String lastName;
  String pictureUrl;
  String phoneNumber;
  String mail;
  int age;
  String bio;
  String status;
  Gender gender;
  List<Skill> skills = [];
  List<Formation> formations = [];
  List<Experience> experiences = [];

  User(
      {this.uid,
      this.firstName,
      this.lastName,
      this.mail,
      this.phoneNumber,
      this.pictureUrl,
      this.age,
      this.bio,
      this.status,
      this.gender});

  String displayName() {
    String lastName =
        this.lastName.isNotEmpty ? this.lastName.toUpperCase() : '';
    String firstName = this.firstName.isNotEmpty
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
        pictureUrl = snapshot.data()[UserRepository.pictureUrlReference] ?? '',
        age = snapshot.data()[UserRepository.ageReference] ?? 0,
        bio = snapshot.data()[UserRepository.bioReference] ?? '',
        status = snapshot.data()[UserRepository.statusReference] ?? '',
        gender = snapshot.data()[UserRepository.genderReference];

  Map<String, dynamic> toJson() => {
        UserRepository.mailReference: mail ?? '',
        UserRepository.firstNameReference: firstName ?? '',
        UserRepository.lastNameReference: lastName ?? '',
        UserRepository.pictureUrlReference: pictureUrl ?? '',
        UserRepository.phoneNumberReference: phoneNumber ?? '',
        UserRepository.ageReference: age,
        UserRepository.bioReference: bio ?? '',
        UserRepository.statusReference: status ?? '',
        UserRepository.genderReference: gender
      };
}
