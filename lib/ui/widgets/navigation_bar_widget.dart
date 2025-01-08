import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../blocs/recent_artists_cubit.dart';
import '../../service/recent_researh_service.dart';
import '../screens/home_screen.dart';
import '../screens/search_view.dart';

class NavigationBar extends StatelessWidget {
  final RecentSearchesService searchesService;
  final RecentArtistsCubit recentArtistsCubit;

  const NavigationBar({
    required this.searchesService,
    required this.recentArtistsCubit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: CupertinoColors.systemBackground,
        inactiveColor: CupertinoColors.systemGrey,
        iconSize: 27,
        height: 60,
        items: const <BottomNavigationBarItem>[
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
        onTap: (index) {
          if (index == 0) {
            recentArtistsCubit.loadRecentArtists();
          }
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return BlocProvider.value(
              value: recentArtistsCubit,
              child: index == 0
                  ? const HomeScreen()
                  : SearchUi(searchesService: searchesService),
            );
          },
        );
      },
    );
  }
}