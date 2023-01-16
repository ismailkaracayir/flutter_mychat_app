import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_proje_app/services/storage_base.dart';

class FirebaseStorageService implements StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Reference? _storageReferance;
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  @override
  Future<String> uploadFile(
      String userID, String fileType, File uploadFile) async {
    try {
      _storageReferance = _firebaseStorage.ref().child(userID).child(fileType);
      UploadTask uploadTask = _storageReferance!.putFile(uploadFile);
      var url;
      await uploadTask.whenComplete(() async {
        url = await _storageReferance!.getDownloadURL();
      });
      return url;
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  Future<String> uploadImgDateFile(
      String userID, String fileType, File uploadFile) async {
    try {
      var _messageID = _firebaseDB.collection('konusmalar').doc().id;

      _storageReferance =
          _firebaseStorage.ref().child(_messageID).child(fileType);
      UploadTask uploadTask = _storageReferance!.putFile(uploadFile);
      var url;
      await uploadTask.whenComplete(() async {
        url = await _storageReferance!.getDownloadURL();
      });
      return url;
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }
}
