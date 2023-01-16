import 'package:flutter_chat_proje_app/repository/user_repository.dart';
import 'package:flutter_chat_proje_app/services/fake_firebase_auth.dart';
import 'package:flutter_chat_proje_app/services/firebase_auth_service.dart';
import 'package:flutter_chat_proje_app/services/firebase_storage_service.dart';
import 'package:flutter_chat_proje_app/services/firestore_db.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => FirebaseAuthService());
  getIt.registerLazySingleton(() => FakeAuth());
  getIt.registerLazySingleton(() => UserRepository());
  getIt.registerLazySingleton(() => FirestoreDBServices());
  getIt.registerLazySingleton(() => FirebaseStorageService());
}
