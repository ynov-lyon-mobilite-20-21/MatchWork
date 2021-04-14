import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_work/core/repositories/user_repository.dart';

class Experience {
  String id;
  String company;
  String job;
  String startDate;
  String endDate;
  String description;

  Experience(
      {this.id,
      this.company,
      this.job,
      this.startDate,
      this.endDate,
      this.description});

  Experience.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        company = snapshot.data()[UserRepository.experienceCompanyReference],
        job = snapshot.data()[UserRepository.experienceJobReference],
        startDate =
            snapshot.data()[UserRepository.experienceStartDateReference],
        endDate = snapshot.data()[UserRepository.experienceEndDateReference],
        description =
            snapshot.data()[UserRepository.experienceDescriptionReference];

  Map<String, dynamic> toJson() => {
        UserRepository.experienceCompanyReference: company,
        UserRepository.experienceJobReference: job,
        UserRepository.experienceStartDateReference: startDate,
        UserRepository.experienceEndDateReference: endDate,
        UserRepository.experienceDescriptionReference: description
      };
}
