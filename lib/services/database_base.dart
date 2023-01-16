import 'package:flutter_chat_proje_app/models/message_model.dart';
import 'package:flutter_chat_proje_app/models/user_model.dart';

abstract class DBBase {
  Future<bool> saveUser(UserModel user);
  Future<UserModel> readUser(String userID);
  Future<bool> updateUserName(String userID, String newUserName);
  Future<bool> updateProfilImgURL(String userID, String newURl);
  Future<List<UserModel>> getAllUser();
  Stream<List<Message>> getMessages(String currentUsrID, String chatUserID);
  Future<bool> saveMessage(Message saveMessage);
}
