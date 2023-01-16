import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_proje_app/locator.dart';
import 'package:flutter_chat_proje_app/models/message_model.dart';
import 'package:flutter_chat_proje_app/models/user_model.dart';
import 'package:flutter_chat_proje_app/services/auth_base.dart';
import 'package:flutter_chat_proje_app/services/fake_firebase_auth.dart';
import 'package:flutter_chat_proje_app/services/firebase_auth_service.dart';
import 'package:flutter_chat_proje_app/services/firebase_storage_service.dart';
import 'package:flutter_chat_proje_app/services/firestore_db.dart';

enum AppMod { debug, release }

class UserRepository implements AuthBase {
  final FirebaseAuthService firebaseAuthService = getIt<FirebaseAuthService>();
  final FirestoreDBServices firebaseFirestoreAut = getIt<FirestoreDBServices>();
  final FirebaseStorageService firebaseStorageService =
      getIt<FirebaseStorageService>();
  final FakeAuth fakeAuth = getIt<FakeAuth>();
  AppMod appMod = AppMod.release;
  @override
  Future<UserModel> currentUser() async {
    if (appMod == AppMod.debug) {
      return await fakeAuth.currentUser();
    } else {
      UserModel user = await firebaseAuthService.currentUser();
      return await FirestoreDBServices().readUser(user.userID!);
    }
  }

  @override
  Future<UserModel> singInAnonymously() async {
    if (appMod == AppMod.debug) {
      return await fakeAuth.singInAnonymously();
    } else {
      return await firebaseAuthService.singInAnonymously();
    }
  }

  @override
  Future<bool> singOut() async {
    if (appMod == AppMod.debug) {
      return await fakeAuth.singOut();
    } else {
      return await firebaseAuthService.singOut();
    }
  }

  @override
  Future<UserModel> singInWithGoogle() async {
    if (appMod == AppMod.debug) {
      return await fakeAuth.singInWithGoogle();
    } else {
      UserModel user = await firebaseAuthService.singInWithGoogle();
      bool sonuc = await firebaseFirestoreAut.saveUser(user);
      if (sonuc) {
        UserModel kayitUser =
            await FirestoreDBServices().readUser(user.userID!);
        return kayitUser;
      } else
        return UserModel(userID: null, email: null);
    }
  }

  @override
  Future<UserModel> createWithUserEmailAndPass(
      String email, String pass) async {
    if (appMod == AppMod.debug) {
      return await fakeAuth.createWithUserEmailAndPass(email, pass);
    } else {
      UserModel user =
          await firebaseAuthService.createWithUserEmailAndPass(email, pass);
      bool _sonuc = await firebaseFirestoreAut.saveUser(user);
      debugPrint('kullanici firestore kayıt durumu : $_sonuc');
      if (_sonuc) {
        return FirestoreDBServices().readUser(user.userID!);
      } else
        return UserModel(userID: null, email: null);
    }
  }

  @override
  Future<UserModel> singInWithEmailAndPass(String email, String pass) async {
    if (appMod == AppMod.debug) {
      return await fakeAuth.singInWithEmailAndPass(email, pass);
    } else {
      UserModel user =
          await firebaseAuthService.singInWithEmailAndPass(email, pass);
      return await FirestoreDBServices().readUser(user.userID!);
    }
  }

  @override
  Future<UserModel> singInWithTwitter() {
    throw UnimplementedError();
  }

  Future<bool> updateUserName(String userID, String newUserName) async {
    if (appMod == AppMod.debug) {
      return false;
    } else {
      return await FirestoreDBServices().updateUserName(newUserName, userID);
    }
  }

  Future<String> uploadFile(
      String userID, String fileType, File uploadFile) async {
    if (appMod == AppMod.debug) {
      return 'dosya indirme linki';
    } else {
      return await FirebaseStorageService()
          .uploadFile(userID, fileType, uploadFile);
    }
  }
    Future<String> uploadImgDateFile(
      String userID, String fileType, File uploadFile) async {
    if (appMod == AppMod.debug) {
      return 'dosya indirme linki';
    } else {
      return await FirebaseStorageService()
          .uploadImgDateFile(userID, fileType, uploadFile);
    }
  }

  Future<bool> updateProfilImgURL(String? userID, String url) async {
    if (appMod == AppMod.debug) {
      return false;
    } else {
      return await FirestoreDBServices().updateProfilImgURL(userID!, url);
    }
  }

  Future<List<UserModel>> getAllUser() async {
    return await FirestoreDBServices().getAllUser();
  }

  Stream<List<Message>> getMessages(String currentUsrID, String chatUserID) {
    if (appMod == AppMod.debug) {
      return const Stream.empty();
    } else {
      return FirestoreDBServices().getMessages(currentUsrID, chatUserID);
    }
  }

  Future<bool> saveMessage(Message saveMessage) async {
    if (appMod == AppMod.debug) {
      return true;
    } else {
      return FirestoreDBServices().saveMessage(saveMessage);
    }
  }
}
