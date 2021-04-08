import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:flutter/material.dart';
import 'package:match_work/core/models/experience.dart';
import 'package:match_work/core/models/formation.dart';
import 'package:match_work/core/models/skill.dart';
import 'package:match_work/core/models/user.dart';

class UserRepository {
  static String firstNameReference = 'firstName';
  static String lastNameReference = 'lastName';
  static String phoneNumberReference = 'phoneNumber';
  static String mailReference = 'mail';
  static String pictureUrlReference = 'pictureUrl';
  static String ageReference = 'age';
  static String bioReference = 'bio';
  static String skillsReference = 'skills';
  static String formationsReference = 'formations';
  static String experiencesReference = 'experiences';

  static String skillLabelReference = 'label';

  static String formationSchoolReference = 'school';
  static String formationStartYearReference = 'startYear';
  static String formationEndYearReference = 'endYear';
  static String formationDegreeReference = 'degree';
  static String formationDescriptionReference = 'description';

  static String experienceCompanyReference = 'company';
  static String experienceStartYearReference = 'startYear';
  static String experienceEndYearReference = 'endYear';
  static String experienceJobReference = 'job';
  static String experienceDescriptionReference = 'description';

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Stream<User> userStream({@required Firebase.User firebaseUser}) =>
      _usersCollection
          .doc(firebaseUser.uid)
          .snapshots()
          .map((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          return User.fromSnapshot(snapshot);
        } else {
          User user = User(
            uid: firebaseUser.uid,
            mail: firebaseUser.email,
          );
          createUser(user);
          return user;
        }
      });

  Stream<List<User>> getAllUsersStream() {
    return _usersCollection
        .snapshots()
        .asyncMap((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.length == 0) return [];
      return Future.wait(
          querySnapshot.docs.map((DocumentSnapshot snapshot) async {
        User user = User.fromSnapshot(snapshot);
        user.skills = await getSkillsByUser(user);
        user.formations = await getFormationsByUser(user);
        user.experiences = await getExperiencesByUser(user);
        return user;
      }));
    });
  }

  Future<User> getUserByUid(String uid) async {
    try {
      DocumentSnapshot snapshot = await _usersCollection.doc(uid).get();

      if (snapshot.exists) {
        return User.fromSnapshot(snapshot);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> getUserByMail(String mail) async {
    QuerySnapshot querySnapshot = await _usersCollection
        .where(mailReference, isEqualTo: mail)
        .limit(1)
        .get();
    if (querySnapshot.docs.length > 0) {
      return User.fromSnapshot(querySnapshot.docs.first);
    }
    return null;
  }

  Future<bool> createUser(User user) async {
    try {
      await _usersCollection.doc(user.uid).set(user.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateUser(User user) async {
    try {
      await _usersCollection.doc(user.uid).set(user.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> createSkill({@required Skill skill, @required User user}) async {
    try {
      await _usersCollection
          .doc(user.uid)
          .collection(skillsReference)
          .add(skill.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Skill>> getSkillsByUser(User user) async {
    List<Skill> skills = [];

    var snapshots =
        await _usersCollection.doc(user.uid).collection(skillsReference).get();
    snapshots.docs
        .forEach((snapshot) => skills.add(Skill.fromSnapshot(snapshot)));

    return skills;
  }

  Future<bool> createFormation(
      {@required Formation formation, @required User user}) async {
    try {
      await _usersCollection
          .doc(user.uid)
          .collection(formationsReference)
          .add(formation.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Formation>> getFormationsByUser(User user) async {
    List<Formation> formations = [];

    var snapshots = await _usersCollection
        .doc(user.uid)
        .collection(formationsReference)
        .get();
    snapshots.docs.forEach(
        (snapshot) => formations.add(Formation.fromSnapshot(snapshot)));

    return formations;
  }

  Future<bool> createExperience(
      {@required Experience experience, @required User user}) async {
    try {
      await _usersCollection
          .doc(user.uid)
          .collection(experiencesReference)
          .add(experience.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Experience>> getExperiencesByUser(User user) async {
    List<Experience> experiences = [];

    var snapshots = await _usersCollection
        .doc(user.uid)
        .collection(experiencesReference)
        .get();
    snapshots.docs.forEach(
        (snapshot) => experiences.add(Experience.fromSnapshot(snapshot)));

    return experiences;
  }
}
