import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  StreamController<User> _userController = StreamController<User>();
  Stream<User> get user => _userController.stream;

  FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationService() {
    _auth.authStateChanges().listen((User user) => _userController.add(user));
  }

  Future<String> registrationWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
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
    } on FirebaseAuthException catch (e) {
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
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await _auth.signInWithCredential(credential);

    return _auth.currentUser != null ? null : 'Erreur';
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
