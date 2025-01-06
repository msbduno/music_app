import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/blocs/discogs_search_cubit.dart';
import 'package:music_app/repositories/discogs_repository.dart';

class SearchUi extends StatelessWidget {
  const SearchUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscogsSearchCubit(DiscogsRepository()),
      child: SearchView(),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

