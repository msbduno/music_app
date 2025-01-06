import 'package:flutter/cupertino.dart';
import 'package:music_app/ui/screens/home_screen.dart';
import 'package:music_app/ui/screens/search_sreen.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: CupertinoColors.systemBackground,
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.systemGrey,
        iconSize: 27, // Taille des icônes
        height: 60, // Hauteur des éléments


        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Icon(CupertinoIcons.house_fill),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Icon(CupertinoIcons.search),
            ),
            label: 'Search',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (BuildContext context) => HomeScreen(),
            );
          case 1:
            return CupertinoTabView(
              builder: (BuildContext context) => SearchScreen(),
            );
          default:
            return CupertinoTabView(
              builder: (BuildContext context) => HomeScreen(),
            );
        }
      },
    );
  }

}

