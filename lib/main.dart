import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/repositories/discogs_repository.dart';
import 'package:music_app/service/recent_researh_service.dart';
import 'package:music_app/ui/screens/search_view.dart';
import 'package:music_app/ui/widgets/navigation_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'blocs/discogs_search_cubit.dart';
import 'blocs/recent_artists_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final _discogsSearchCubit = DiscogsSearchCubit(DiscogsRepository());
  final searchesService = RecentSearchesService(prefs, _discogsSearchCubit);

  runApp(MyApp(searchesService: searchesService));
}

class MyApp extends StatelessWidget {
  final RecentSearchesService searchesService;

  const MyApp({required this.searchesService, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => RecentArtistsCubit(searchesService),
        ),
        // Add other providers here if needed
      ],
      child: CupertinoApp(
        home: NavigationBar(searchesService: searchesService),
        debugShowCheckedModeBanner: false,
        routes: {
          '/search': (context) => SearchUi(searchesService: searchesService),
        },
      ),
    );
  }
}