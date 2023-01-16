
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_proje_app/models/user_model.dart';
import 'package:flutter_chat_proje_app/services/auth_base.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthBase {
  User? user = FirebaseAuth.instance.currentUser;
  var _credential;

  @override
  Future<UserModel> currentUser() async {
    try {
      return _userModelFromFirebase(user);
    } catch (e) {
      debugPrint('hata cıktı currentuser ${e.toString()}');
      return UserModel(userID: null, email: null);
    }
  }

  UserModel _userModelFromFirebase(User? user) {
    if (user == null) {
      return UserModel(userID: null, email: null);
    }
    return UserModel(userID: user.uid, email: user.email);
  }

  @override
  Future<bool> singOut() async {
    try {
      final _googleSingIn = GoogleSignIn();
      _googleSingIn.signOut();
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      debugPrint('singOut hata ${e.toString()}');
      return false;
    }
  }

  @override
  Future<UserModel> singInAnonymously() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      return _userModelFromFirebase(userCredential.user);
    } catch (e) {
      debugPrint('Anonim oturum acma sorun${e.toString()}');
      return UserModel(userID: null, email: null);
    }
  }

  @override
  Future<UserModel> singInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return _userModelFromFirebase(userCredential.user);
    } catch (e) {
      debugPrint(
          'google oturum acma işlemi hata çıktı firebase_auth_service${e.toString()}');
      return UserModel(userID: null, email: null);
    }
  }

  @override
  Future<UserModel> createWithUserEmailAndPass(
      String email, String pass) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass);
    return _userModelFromFirebase(userCredential.user);
  }

  @override
  Future<UserModel> singInWithEmailAndPass(String email, String pass) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
    return _userModelFromFirebase(userCredential.user);
  }

  @override
  Future<UserModel> singInWithTwitter() {
    // TODO: implement singInWithTwitter
    throw UnimplementedError();
  }
}
