import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_proje_app/models/message_model.dart';
import 'package:flutter_chat_proje_app/models/user_model.dart';
import 'package:flutter_chat_proje_app/services/database_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDBServices implements DBBase {
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;
  @override
  Future<bool> saveUser(UserModel user) async {
    await _firebaseDB.collection('users').doc(user.userID).set(user.ToMap());

    DocumentSnapshot _okunanUser =
        await FirebaseFirestore.instance.doc("users/${user.userID}").get();
    Map _okunanUserBilgileri = _okunanUser.data() as Map;
    UserModel okunanUser = UserModel.fromMap(_okunanUserBilgileri);
    debugPrint(okunanUser.toString());

    return true;
  }

  @override
  Future<UserModel> readUser(String userID) async {
    DocumentSnapshot okunanUser =
        await _firebaseDB.collection('users').doc(userID).get();
    UserModel gelenUser = UserModel.fromMap(okunanUser.data() as Map);
    debugPrint(
        '**********okunan user bilgileri ${gelenUser.toString()}***********');
    return gelenUser;
  }

  @override
  Future<bool> updateUserName(String userID, String newUserName) async {
    var users = await _firebaseDB
        .collection('users')
        .where("userName", isEqualTo: newUserName)
        .get();
    if (users.docs.length >= 1) {
      return false;
    } else {
      await _firebaseDB
          .collection('users')
          .doc(userID)
          .update({'userName': newUserName});
      return true;
    }
  }

  @override
  Future<bool> updateProfilImgURL(String userID, String newURl) async {
    var users = await _firebaseDB
        .collection('users')
        .where("profilImgURL", isEqualTo: newURl)
        .get();
    if (users.docs.length >= 1) {
      return false;
    } else {
      await _firebaseDB
          .collection('users')
          .doc(userID)
          .update({'profilImgURL': newURl});
      return true;
    }
  }

  @override
  Future<List<UserModel>> getAllUser() async {
    QuerySnapshot querySnapshot = await _firebaseDB.collection('users').get();
    List<UserModel> allUser = [];
    for (DocumentSnapshot user in querySnapshot.docs) {
      UserModel tekUser = UserModel.fromMap(user.data() as Map);
      allUser.add(tekUser);
    }
    return allUser;
  }

  @override
  Stream<List<Message>> getMessages(String currentUsrID, String chatUserID) {
    var snapShat = _firebaseDB
        .collection('konusmalar')
        .doc('$currentUsrID--$chatUserID')
        .collection('mesajlar')
        .orderBy('date')
        .snapshots();
    return snapShat.map(
        (event) => event.docs.map((e) => Message.fromMap(e.data())).toList());
  }

  Future<bool> saveMessage(Message saveMessage) async {
    var _messageID = _firebaseDB.collection('konusmalar').doc().id;
    var myDocID = ('${saveMessage.kimden}--${saveMessage.kime}');
    var resiverDocID = ('${saveMessage.kime}--${saveMessage.kimden}');
    await _firebaseDB
        .collection("konusmalar")
        .doc(myDocID)
        .collection("mesajlar")
        .doc(_messageID)
        .set(saveMessage.toMap());
    var a = saveMessage.toMap();
    a.update('bendenMi', (value) => false);
    await _firebaseDB
        .collection("konusmalar")
        .doc(resiverDocID)
        .collection("mesajlar")
        .doc(_messageID)
        .set(a);
    return true;
  }
}
