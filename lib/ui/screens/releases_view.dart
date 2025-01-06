import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/blocs/discogs_artist_cubit.dart';
import 'package:music_app/repositories/discogs_repository.dart';

class ReleasesUi extends StatelessWidget {
  const ReleasesUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DiscogsReleasesCubit(DiscogsRepository()),
        child: const ReleasesView()
    );
  }
}

class ReleasesView extends StatelessWidget {
  const ReleasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

