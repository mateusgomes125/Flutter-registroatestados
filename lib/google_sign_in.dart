//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GoogleSignInController extends ChangeNotifier {
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleAccount;
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // User? usuario;
  // bool isLoading = true;

  // AuthService() {
  //   _authCheck();
  // }

  // _authCheck() {
  //   _auth.authStateChanges().listen((User? user) {
  //     usuario = (user == null) ? null : user;
  //     isLoading = false;
  //     notifyListeners();
  //   });
  // }

  login() async {
    this.googleAccount = await _googleSignIn.signIn();
    notifyListeners();
  }

  logOut() async {
    this.googleAccount = await _googleSignIn.signOut();
    notifyListeners();
  }
}



/*
final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();
    }
*/