import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:match_work/core/repositories/user_repository.dart';

class Skill {
  String id;
  String label;

  Skill({this.id, @required this.label});

  Skill.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        label = snapshot.data()[UserRepository.skillLabelReference];

  Map<String, dynamic> toJson() => {UserRepository.skillLabelReference: label};
}
