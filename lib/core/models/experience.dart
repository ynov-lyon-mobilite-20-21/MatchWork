import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_work/core/repositories/user_repository.dart';

class Experience {
  String id;
  String company;
  String job;
  int startYear;
  int endYear;
  String description;

  Experience(
      {this.id,
      this.company,
      this.job,
      this.startYear,
      this.endYear,
      this.description});

  Experience.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        company = snapshot.data()[UserRepository.experienceCompanyReference],
        job = snapshot.data()[UserRepository.experienceJobReference],
        startYear =
            snapshot.data()[UserRepository.experienceStartYearReference],
        endYear = snapshot.data()[UserRepository.experienceEndYearReference],
        description =
            snapshot.data()[UserRepository.experienceDescriptionReference];

  Map<String, dynamic> toJson() => {
        UserRepository.experienceCompanyReference: company,
        UserRepository.experienceJobReference: job,
        UserRepository.experienceStartYearReference: startYear,
        UserRepository.experienceEndYearReference: endYear,
        UserRepository.experienceDescriptionReference: description
      };
}
