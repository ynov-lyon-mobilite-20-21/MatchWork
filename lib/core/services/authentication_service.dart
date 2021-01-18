import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationService {
  final Firebase.FirebaseAuth _auth = Firebase.FirebaseAuth.instance;
  final UserRepository _userRepository = UserRepository();

  final CompositeSubscription _compositeSubscription = CompositeSubscription();

  BehaviorSubject<User> _userSubject = BehaviorSubject<User>();
  Function(User) get _inUser => _userSubject.sink.add;
  Stream<User> get outUser => _userSubject.stream;
  User get currentUser => _userSubject.value;

  AuthenticationService() {
    _listenOnAuthStateChanged();
  }

  void _listenOnAuthStateChanged() async {
    _compositeSubscription.add(
        _auth.authStateChanges().listen((Firebase.User firebaseUser) async {
      if (firebaseUser == null) {
        _onUserLogout();
      } else {
        _onUserLogin(firebaseUser: firebaseUser);
      }
    }));
  }

  void _onUserLogin({Firebase.User firebaseUser}) async {
    _compositeSubscription.add(_userRepository
        .userStream(firebaseUser: firebaseUser)
        .where((User user) => user != null)
        .listen((User user) {
      if (!_userSubject.isClosed) {
        _inUser(user);
      }
    }));
  }

  void _onUserLogout() {
    _userSubject.value = null;
    _inUser(null);
  }

  Future<bool> isUserLoggedIn() async {
    Firebase.User firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      User user = await _userRepository.getUserByUid(firebaseUser.uid);
      return user != null;
    } else {
      return false;
    }
  }

  Future<String> registrationWithEmailAndPassword(
      {@required String email,
      @required String password,
      @required String name,
      @required String firstName}) async {
    try {
      User userWithSameMail = await _userRepository.getUserByMail(email);
      if (userWithSameMail != null) {
        return 'Cet email est déjà utilisé.';
      }
      Firebase.UserCredential credentials = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = User(
          uid: credentials.user.uid,
          mail: email,
          firstName: firstName,
          lastName: name);
      await _userRepository.updateUser(user);
    } on Firebase.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Le mot de passe n\'est pas assez long.';
      } else if (e.code == 'email-already-in-use') {
        return 'Cet email est déjà utilisé.';
      }
    } catch (e) {
      print(e);
    }
    return _auth.currentUser != null ? null : 'Erreur';
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on Firebase.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Aucun utilisateur trouvé avec cet email.';
      } else if (e.code == 'wrong-password') {
        return 'Mot de passe incorrect.';
      }
    }
    return _auth.currentUser != null ? null : 'Erreur';
  }

  Future<String> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final Firebase.GoogleAuthCredential credential =
        Firebase.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await _auth.signInWithCredential(credential);

    String displayName = _auth.currentUser.displayName;
    String firstName = displayName.split(' ').first.toLowerCase();
    String lastName = displayName.substring(firstName.length + 1).toLowerCase();
    User user = User(
        uid: _auth.currentUser.uid,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: _auth.currentUser.phoneNumber,
        mail: _auth.currentUser.email.toLowerCase(),
        pictureUrl: _auth.currentUser.photoURL);
    await _userRepository.updateUser(user);

    return _auth.currentUser != null ? null : 'Erreur';
  }

  Future signOut() async {
    await _auth.signOut();
  }

  void dispose() {
    _userSubject.close();
    _compositeSubscription.dispose();
  }
}
