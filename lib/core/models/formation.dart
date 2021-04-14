import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_work/core/repositories/user_repository.dart';

class Formation {
  String id;
  String school;
  String startDate;
  String endDate;
  String degree;
  String description;

  Formation(
      {this.id,
      this.school,
      this.startDate,
      this.endDate,
      this.degree,
      this.description});

  Formation.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        school = snapshot.data()[UserRepository.formationSchoolReference],
        startDate = snapshot.data()[UserRepository.formationStartDateReference],
        endDate = snapshot.data()[UserRepository.formationEndDateReference],
        degree = snapshot.data()[UserRepository.formationDegreeReference],
        description =
            snapshot.data()[UserRepository.formationDescriptionReference];

  Map<String, dynamic> toJson() => {
        UserRepository.formationSchoolReference: school,
        UserRepository.formationStartDateReference: startDate,
        UserRepository.formationEndDateReference: endDate,
        UserRepository.formationDegreeReference: degree,
        UserRepository.formationDescriptionReference: description
      };
}
