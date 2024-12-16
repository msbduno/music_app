import 'package:flutter/cupertino.dart';
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
    return CupertinoApp(
      home: const NavigationBar(),
      routes: {
        '/search': (context) => const SearchScreen(),
        '/search_details': (context) => const SearchDetailsScreen( query: ''),
      },
    );
  }
}