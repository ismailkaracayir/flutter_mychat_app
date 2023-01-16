import 'package:flutter_chat_proje_app/models/user_model.dart';
import 'package:flutter_chat_proje_app/services/auth_base.dart';

class FakeAuth implements AuthBase {
  final String fakeUserID = '31313131313131';
  final String fakeUserEmail ='ismaiismail010101@hotmail.com';
  @override
  Future<UserModel> currentUser() async {
    return await Future.value(UserModel(userID: fakeUserID, email:  fakeUserEmail));
  }

  @override
  Future<UserModel> singInAnonymously() async {
    return await Future.delayed(
        const Duration(seconds: 1), (() => UserModel(userID: fakeUserID,email:fakeUserEmail )));
  }

  @override
  Future<bool> singOut() {
    return Future.value(true);
  }

  @override
  Future<UserModel> singInWithGoogle() async {
    return await Future.delayed(
        const Duration(seconds: 1), (() => UserModel(userID: fakeUserID, email:  fakeUserEmail)));
  }
  
  @override
  Future<UserModel> createWithUserEmailAndPass(String email, String pass) {
    // TODO: implement createWithUserEmailAndPass
    throw UnimplementedError();
  }
  
  @override
  Future<UserModel> singInWithEmailAndPass(String email, String pass) {
    // TODO: implement singInWithEmailAndPass
    throw UnimplementedError();
  }
  
  @override
  Future<UserModel> singInWithTwitter() {
    // TODO: implement singInWithTwitter
    throw UnimplementedError();
  }
}
