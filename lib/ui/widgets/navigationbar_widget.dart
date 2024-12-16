import 'package:flutter/cupertino.dart';
import 'package:music_app/ui/screens/home_screen.dart';
import 'package:music_app/ui/screens/search_sreen.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
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