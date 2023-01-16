import 'package:flutter/material.dart';

class ExceptionHata {
  static String hatalar(String hataCode) {
    debugPrint(hataCode);
    switch (hataCode) {
      case '[firebase_auth/email-already-in-use] The email address is already in use by another account.':
        return "Bu mail Adresi zaten kullanımda farklı bir email adresi ile deneyiniz...";
      case '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.':
        return "Kayıtlı Böyle Bir Kullanıcı Bulunamadı...";

      default:
        return "hata oluştu";
    }
  }
}
