import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/repositories/discogs_repository.dart';
import 'package:music_app/service/recent_researh_service.dart';
import 'package:music_app/ui/widgets/navigation_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/discogs_search_cubit.dart';
import 'blocs/recent_artists_cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final discogsRepository = DiscogsRepository();
  final discogsSearchCubit = DiscogsSearchCubit(discogsRepository);
  final searchesService = RecentSearchesService(prefs, discogsSearchCubit);
  final recentArtistsCubit = RecentArtistsCubit(searchesService);

  runApp(MyApp(
    searchesService: searchesService,
    recentArtistsCubit: recentArtistsCubit,
  ));
}

class MyApp extends StatelessWidget {
  final RecentSearchesService searchesService;
  final RecentArtistsCubit recentArtistsCubit;

  const MyApp({
    required this.searchesService,
    required this.recentArtistsCubit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RecentArtistsCubit>.value(value: recentArtistsCubit),
      ],
      child: CupertinoApp(
        home: NavigationBar(
          searchesService: searchesService,
          recentArtistsCubit: recentArtistsCubit,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}