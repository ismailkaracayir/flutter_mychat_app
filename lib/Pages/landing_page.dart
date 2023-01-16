import 'package:flutter/material.dart';
import 'package:flutter_chat_proje_app/Pages/homepage.dart';
import 'package:flutter_chat_proje_app/Pages/sing_in/sing_in_page.dart';

import 'package:flutter_chat_proje_app/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _usermodel = Provider.of<UserViewModel>(context);

    if (_usermodel.state == ViewState.Idle) {
      if (_usermodel.user != null) {
        debugPrint('landing page tetiklendi homepage ye gidiliyor ' + _usermodel.user!.userID.toString());
        return MyHomePage(user: _usermodel.user);
      } else {
        return SingInPage();
      }
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
