import 'package:flutter/material.dart';
import 'package:flutter_chat_proje_app/Pages/kullanicilar.dart';
import 'package:flutter_chat_proje_app/Pages/my_custom_bottom_navi.dart';
import 'package:flutter_chat_proje_app/Pages/profil.dart';
import 'package:flutter_chat_proje_app/Pages/tab_items_navi.dart';
import 'package:flutter_chat_proje_app/models/user_model.dart';

class MyHomePage extends StatefulWidget {
  UserModel? user;

  MyHomePage({required this.user, super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

TabItems _currentTab = TabItems.Kullanicilar;
Map<TabItems, Widget> Sayfalar() {
  return {
    TabItems.Kullanicilar: const KullanicilarPage(),
    TabItems.Profil: ProfilPage(),
  };
}

Map<TabItems, GlobalKey<NavigatorState>> navigatorKey = {
  TabItems.Kullanicilar: GlobalKey<NavigatorState>(),
  TabItems.Profil: GlobalKey<NavigatorState>(),
};

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navigatorKey[_currentTab]!.currentState!.maybePop(),
      child: MyCustomBottomNavigator(
        navigatorKey: navigatorKey,
        currentTab: _currentTab,
        sayfaOlusturucu: Sayfalar(),
        onselectedTab: (selectedTab) {
          setState(() {
            _currentTab = selectedTab;
          });
        },
      ),
    );
  }
}
 /*  Future<void> _cikisYap(BuildContext context) async {
    final _usermodel = Provider.of<UserViewModel>(context, listen: false);
    _usermodel.singOut();
  }*/