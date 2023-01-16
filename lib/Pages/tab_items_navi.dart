import 'package:flutter/material.dart';

enum TabItems { Kullanicilar, Profil }

class TabItemData {
  final String? title;
  final IconData? icon;

  TabItemData(   this.title,   this.icon);

  static Map<TabItems,TabItemData> tumTablar={
    TabItems.Kullanicilar: TabItemData('Kullanıcılar', Icons.supervised_user_circle),
    TabItems.Profil:TabItemData('Profil', Icons.person),

  };
}
