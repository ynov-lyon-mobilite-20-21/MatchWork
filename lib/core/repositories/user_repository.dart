import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:flutter/material.dart';
import 'package:match_work/core/models/user.dart';

class UserRepository {
  static String firstNameReference = 'firstName';
  static String lastNameReference = 'lastName';
  static String phoneNumberReference = 'phoneNumber';
  static String mailReference = 'mail';
  static String pictureUrlReference = 'pictureUrl';

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
}
