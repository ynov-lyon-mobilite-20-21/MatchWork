import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_work/core/repositories/user_repository.dart';

class Formation {
  String id;
  String school;
  int startYear;
  int endYear;
  String degree;
  String description;

  Formation(
      {this.id,
      this.school,
      this.startYear,
      this.endYear,
      this.degree,
      this.description});

  Formation.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        school = snapshot.data()[UserRepository.formationSchoolReference],
        startYear = snapshot.data()[UserRepository.formationStartYearReference],
        endYear = snapshot.data()[UserRepository.formationEndYearReference],
        degree = snapshot.data()[UserRepository.formationDegreeReference],
        description =
            snapshot.data()[UserRepository.formationDescriptionReference];

  Map<String, dynamic> toJson() => {
        UserRepository.formationSchoolReference: school,
        UserRepository.formationStartYearReference: startYear,
        UserRepository.formationEndYearReference: endYear,
        UserRepository.formationDegreeReference: degree,
        UserRepository.formationDescriptionReference: description
      };
}
