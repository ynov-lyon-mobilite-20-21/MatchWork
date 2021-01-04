import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String firstName;
  String lastName;
  String pictureUrl;
  String phoneNumber;
  String mail;

  User(
      {this.uid,
      this.firstName,
      this.lastName,
      this.mail,
      this.phoneNumber,
      this.pictureUrl});

  String displayName() =>
      this.lastName.toUpperCase() +
      ' ' +
      this.firstName[0].toUpperCase() +
      this.firstName.substring(1).toLowerCase();

  User.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot.id,
        phoneNumber = snapshot.data()['phoneNumber'] ?? '',
        mail = snapshot.data()['mail'] ?? '',
        lastName = snapshot.data()['lastName'] ?? '',
        firstName = snapshot.data()['firstName'] ?? '',
        pictureUrl = snapshot.data()['pictureUrl'] ?? '';

  Map<String, dynamic> toJson() => {
        'mail': mail ?? '',
        'firstName': firstName ?? '',
        'lastName': lastName ?? '',
        'pictureUrl': pictureUrl ?? '',
        'phoneNumber': phoneNumber ?? ''
      };
}
