import 'package:flutter/material.dart';
import 'package:flutter_chat_proje_app/Pages/sing_in/email-pass_sing_in.dart';
import 'package:flutter_chat_proje_app/models/user_model.dart';

import 'package:flutter_chat_proje_app/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../widgets/social_sing_in_button.dart';

class SingInPage extends StatelessWidget {
  const SingInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white70,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'MyChat',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
           Container (
            height: 180,
            child:const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir.  galerisini alarak karıştırdığı 1500'lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kal.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  shadows: [
                    Shadow(
                      blurRadius: 200.0, // shadow blur
                      color: Colors.deepOrange, // shadow color
                      offset: Offset(1.0, 1.0), // how much shadow will be shown
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: SocialSingInWidget(
                buttonText: 'Google İle Giriş',
                buttonColor: Colors.white,
                onPress: () {
                  _googleSingIn(context);
                },
                buttonIcon: Image.asset("images/google-logo.png")),
          ),
          // Center(
          //   child: SocialSingInWidget(
          //       buttonText: ' Twitter İle Giriş',
          //       onPress: () {},
          //       buttonColor: const Color(0xFF00acee),
          //       textColor: Colors.white,
          //       buttonIcon: Image.asset(
          //         "images/twitter-logo.png",
          //         color: Colors.white,
          //         width: 35,
          //       )),
          // ),
          // Center(
          //   child: SocialSingInWidget(
          //       buttonText: 'Telefon ile Giriş',
          //       buttonColor: Colors.deepOrange.shade300,
          //       onPress: () {
          //         _phoneNumSingIn(context);
          //       },
          //       buttonIcon: const Icon(
          //         Icons.phone_android,
          //         size: 35,
          //       )),
          // ),
          Center(
            child: SocialSingInWidget(
              buttonText: 'Email İle Giriş ',
              onPress: () {
                _emailPassSingIn(context);
              },
              buttonColor: Colors.deepOrange,
              buttonIcon: const Icon(
                Icons.email,
                size: 35,
              ),
            ),
          ),
          Center(
            child: SocialSingInWidget(
              buttonText: 'Misafir Giriş ',
              onPress: (() {
                _anonimSingIn(context);
              }),
              buttonColor: Colors.brown.shade400,
              buttonIcon: const Icon(
                Icons.account_box,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _anonimSingIn(BuildContext context) async {
    final _usermodel = Provider.of<UserViewModel>(context, listen: false);
    UserModel _user = await _usermodel.singInAnonymously();
    debugPrint('oturum açan ${_user.userID.toString()}');
  }

  void _googleSingIn(BuildContext context) async {
    final _usermodel = Provider.of<UserViewModel>(context, listen: false);
    UserModel _user = await _usermodel.singInWithGoogle();
    debugPrint('oturum açan ${_user.userID.toString()}');
  }

  void _emailPassSingIn(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: ((context) => const SingInEmailPassPage()),
      ),
    );
  }

  // void _phoneNumSingIn(BuildContext context) {
  //    Navigator.of(context).push(
  //     MaterialPageRoute(
  //       fullscreenDialog: true,
  //       builder: ((context) => const SingInPhoneNumberPage()),
  //     ),
  //   );
  // }
}
