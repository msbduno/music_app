import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../blocs/recent_artists_cubit.dart';
import '../../service/recent_researh_service.dart';
import '../screens/home_screen.dart';
import '../screens/search_view.dart';

class NavigationBar extends StatelessWidget {
  final RecentSearchesService searchesService;

  const NavigationBar({required this.searchesService, super.key});

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
            // Recharge les artistes récents quand on retourne à l'accueil
            final cubit = context.read<RecentArtistsCubit>();
            cubit.loadRecentArtists();
          }
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (BuildContext context) => BlocProvider(
                create: (context) => RecentArtistsCubit(searchesService)..loadRecentArtists(),
                child: const HomeScreen(),
              ),
            );
          case 1:
            return CupertinoTabView(
              builder: (BuildContext context) => SearchUi(searchesService: searchesService),
            );
          default:
            return CupertinoTabView(
              builder: (BuildContext context) => BlocProvider(
                create: (context) => RecentArtistsCubit(searchesService)..loadRecentArtists(),
                child: const HomeScreen(),
              ),
            );
        }
      },
    );
  }
}