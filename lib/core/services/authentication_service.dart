import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:match_work/core/models/user.dart';
import 'package:match_work/core/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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

    await updateUserByAuth();

    return _auth.currentUser != null ? null : 'Erreur';
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<String> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = Firebase.OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    await Firebase.FirebaseAuth.instance.signInWithCredential(oauthCredential);

    await updateUserByAuth();

    return _auth.currentUser != null ? null : 'Erreur';
  }

  Future<void> updateUserByAuth() async {
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
  }

  Future signOut() async {
    await _auth.signOut();
  }

  void dispose() {
    _userSubject.close();
    _compositeSubscription.dispose();
  }
}
