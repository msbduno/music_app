import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/blocs/search_cubit.dart';
import 'package:music_app/repositories/spotify_repository.dart';
import 'package:music_app/ui/screens/search_details_screen.dart';
import 'package:music_app/ui/screens/search_sreen.dart';
import 'package:music_app/ui/widgets/navigationbar_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SpotifyRepository spotifyRepository = SpotifyRepository();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: spotifyRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SearchCubit(spotifyRepository),
          ),
        ],
        child: CupertinoApp(
          home: const NavigationBar(),
          debugShowCheckedModeBanner: false,
          routes: {
            '/search': (context) => const SearchScreen(),
            '/search_details': (context) => const SearchDetailsScreen(query: ''),
          },
        ),
      ),
    );
  }
}