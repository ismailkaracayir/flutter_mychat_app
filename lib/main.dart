import 'package:flutter/material.dart';
import 'package:flutter_chat_proje_app/Pages/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chat_proje_app/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: const LandingPage(),
      ),
    );
  }
}
