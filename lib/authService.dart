import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthService {
  final googleSignIn = GoogleSignIn();
  final facebookSignIn = FacebookLogin();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<SnackBar> signIn(
      {String email, String password, BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return SnackBar(
        content: Text(
          "Login Berhasil!",
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      if (e.message ==
          'There is no user record corresponding to this identifier. The user may have been deleted.') {
        return SnackBar(
          content: Text("Email tidak terdaftar!"),
          backgroundColor: Colors.red,
        );
      }
      if (e.message ==
          'The password is invalid or the user does not have a password.') {
        return SnackBar(
          content: Text("Password Salah!"),
          backgroundColor: Colors.red,
        );
      }
      if (e.message == 'The email address is badly formatted.') {
        return SnackBar(
          content: Text("Periksa kembali email anda!!"),
          backgroundColor: Colors.red,
        );
      }
      if (e.message ==
          'A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
        return SnackBar(
          content: Text("Terjadi kesalahan terhadap jaringan anda!"),
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      if (e == null) {
        return "Email atau Password Salah!";
      }
    }
  }

  logout() async {
    try {
      await _firebaseAuth.signOut();
      await googleSignIn.signOut();
      await facebookSignIn.logOut();
      return "Logout!!!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signInGoogle() async {
    final us = await googleSignIn.signIn();
    final googleAuth = await us.authentication;
    final creden = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    try {
      await _firebaseAuth.signInWithCredential(creden);
      return "Berhasil";
    } catch (e) {
      return "error : " + e;
    }
  }

  Future<String> signInFacebook() async {
    final us = await facebookSignIn.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email
    ]);
    final FacebookAccessToken accessToken = us.accessToken;
    final AuthCredential authCredential =
        FacebookAuthProvider.credential(accessToken.token);
    try {
      await _firebaseAuth.signInWithCredential(authCredential);
      return "Berhasil";
    } catch (e) {
      return "error : " + e;
    }
  }
}
