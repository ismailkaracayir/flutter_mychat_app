import 'package:flutter_chat_proje_app/Pages/tab_items_navi.dart';
import 'package:flutter/cupertino.dart';

class MyCustomBottomNavigator extends StatelessWidget {
  final TabItems currentTab;
  final ValueChanged<TabItems> onselectedTab;
  final Map<TabItems, Widget> sayfaOlusturucu;
  final Map<TabItems, GlobalKey<NavigatorState>> navigatorKey;

  const MyCustomBottomNavigator(
      {super.key,
      required this.currentTab,
      required this.onselectedTab,
      required this.sayfaOlusturucu,
      required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          navItemOlustur(TabItems.Kullanicilar),
          navItemOlustur(TabItems.Profil),
        ],
        onTap: (value) => onselectedTab(TabItems.values[value]),
      ),
      tabBuilder: (context, index) {
        final gosterilecekItem = TabItems.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKey[gosterilecekItem],
          builder: (context) {
            return sayfaOlusturucu[gosterilecekItem]!;
          },
        );
      },
    );
  }

  BottomNavigationBarItem navItemOlustur(TabItems tabItems) {
    final olusturulanTab = TabItemData.tumTablar[tabItems]!;
    return BottomNavigationBarItem(
        icon: Icon(olusturulanTab.icon), label: olusturulanTab.title);
  }
}
