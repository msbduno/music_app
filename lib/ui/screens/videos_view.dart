import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/discogs_videos_cubit.dart';
import '../../repositories/discogs_repository.dart';

class VideosUi extends StatelessWidget {
  const VideosUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DiscogsVideosCubit(DiscogsRepository()),
        child: const VideosView());
  }
}

class VideosView extends StatelessWidget {
  const VideosView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

