import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_chat_proje_app/locator.dart';
import 'package:flutter_chat_proje_app/models/message_model.dart';
import 'package:flutter_chat_proje_app/models/user_model.dart';
import 'package:flutter_chat_proje_app/repository/user_repository.dart';
import 'package:flutter_chat_proje_app/services/auth_base.dart';

enum ViewState { Idle, Busy }

class UserViewModel extends ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.Idle;
  final UserRepository _userRepository = getIt<UserRepository>();
  UserModel? _user;
  String? emailErrorText;
  String? passErrorText;
  String? phoneNumberErrorText;

  UserModel? get user => _user;
  UserViewModel() {
    currentUser();
  }

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    debugPrint('viewstate tetiklendi');
    notifyListeners();
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      return user!;
    } catch (e) {
      debugPrint('viewmodel currentuser da hata cıktı ${e.toString()}');
      return UserModel(userID: null, email: null);
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> singInAnonymously() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.singInAnonymously();
      debugPrint('tetiklendi');
      return user!;
    } catch (e) {
      debugPrint('viewmodel singInAnonymously  da hata cıktı ${e.toString()}');
      return UserModel(userID: null, email: null);
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> singOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _userRepository.singOut();
      _user = null;
      return sonuc;
    } catch (e) {
      debugPrint('viewmodel singOut da hata cıktı ${e.toString()}');
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> singInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.singInWithGoogle();
      debugPrint('tetiklendi');
      return user!;
    } catch (e) {
      debugPrint('viewmodel googleilegiris  da hata cıktı ${e.toString()}');
      return UserModel(userID: null, email: null);
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> createWithUserEmailAndPass(
      String email, String pass) async {
    try {
      if (_emailPassChech(email, pass)) {
        state = ViewState.Busy;
        _user = await _userRepository.createWithUserEmailAndPass(email, pass);
        debugPrint('tetiklendi');
        return user!;
      } else
        return UserModel(userID: null, email: null);
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> singInWithEmailAndPass(String email, String pass) async {
    try {
      if (_emailPassChech(email, pass)) {
        state = ViewState.Busy;
        _user = await _userRepository.singInWithEmailAndPass(email, pass);
        debugPrint('tetiklendi');
        return user!;
      } else
        return UserModel(userID: null, email: null);
    } finally {
      state = ViewState.Idle;
    }
  }

  bool _emailPassChech(String email, String pass) {
    var sonuc = true;
    if (pass.length < 6) {
      sonuc = false;
      passErrorText = 'Şifre 6 karakterden kısa';
    } else {
      passErrorText = null;
    }
    if (!email.contains('@')) {
      sonuc = false;
      emailErrorText = 'Email Uygun Format da Değil';
    } else {
      emailErrorText = null;
    }

    return sonuc;
  }

  @override
  Future<UserModel> singInWithTwitter() {
    // twitter developer hesabını onaylamadı
    throw UnimplementedError();
  }

  Future<bool> updateUserName(String userID, String newUserName) async {
    bool sonuc = await _userRepository.updateUserName(newUserName, userID);
    if (sonuc) {
      _user?.userName = newUserName;
    }
    return sonuc;
  }

  Future<String> uploadFile(
      String userID, String fileType, File uploadFile) async {
    var url = await _userRepository.uploadFile(userID, fileType, uploadFile);
    return url;
  }
   Future<String> uploadImgDateFile(
      String userID, String fileType, File uploadFile) async {
    var url = await _userRepository.uploadImgDateFile(userID, fileType, uploadFile);
    return url;
  }

  Future<bool> updateProfilImgURL(String? userID, String url) async {
    bool sonuc = await _userRepository.updateProfilImgURL(userID, url);
    if (sonuc) {
      _user?.profilImgURL = url;
    }
    return sonuc;
  }

  Future<List<UserModel>> getAllUser() async {
    return await _userRepository.getAllUser();
  }

  Stream<List<Message>> getMessages(String currentUsrID, String chatUserID) {
    return _userRepository.getMessages(currentUsrID, chatUserID);
  }

  Future<bool> saveMessage(Message saveMessage) {
    return _userRepository.saveMessage(saveMessage);
  }
}
