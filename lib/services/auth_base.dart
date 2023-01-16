import 'package:flutter_chat_proje_app/models/user_model.dart';

abstract class AuthBase {
  Future<UserModel> currentUser();
  Future<UserModel> singInAnonymously();
  Future<bool> singOut();
  Future<UserModel> singInWithGoogle();
  Future<UserModel> singInWithTwitter();
  Future<UserModel> singInWithEmailAndPass(String email, String pass);
  Future<UserModel> createWithUserEmailAndPass(String email, String pass);
  

}
