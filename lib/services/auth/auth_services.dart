import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/user_model.dart';
import '../firestore_services.dart';

class AuthServices {
  AuthServices._();

  static AuthServices instance = AuthServices._();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signUp(
      {required String email, required String password}) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  Future<String> login(email, password) async {
    String msg;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      msg = "Success";
    } on FirebaseAuthException catch (e) {
      log("===================${e.code}================");
      switch (e.code) {
        case 'invalid-credential':
          msg = "email or password is invalid";
        case 'operation-not-allowed':
          msg = 'try another way to login';
        default:
          msg = e.code;
      }
    }
    return msg;
  }

  Future<String> loginWithGoogle() async {
    String msg;
    try {
      GoogleSignInAccount? googleUsers = await GoogleSignIn().signIn();

      if (googleUsers != null) {
        GoogleSignInAuthentication googleAuth =
            await googleUsers.authentication;

        var credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await auth.signInWithCredential(credential);

        msg = "Success";
      } else {
        msg = "Not Google Account !!!";
      }
    } on FirebaseAuthException catch (e) {
      msg = e.code;
    }
    return msg;
  }

  Future<void> signOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }

  User? get currentUser => auth.currentUser;
}
