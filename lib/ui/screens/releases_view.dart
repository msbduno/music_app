import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/repositories/discogs_repository.dart';
import '../../blocs/discogs_artist_cubit.dart';
import '../../models/discogs_releases.dart';
import '../../states/discogs_artist_state.dart';
import 'links_screen.dart';

class ReleasesUi extends StatelessWidget {
  final DiscogsReleases artist;

  const ReleasesUi({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscogsReleasesCubit(DiscogsRepository())..searchArtistsReleases(artist.id),
      child: ReleasesView(artist: artist),
    );
  }
}

class ReleasesView extends StatelessWidget {
  final DiscogsReleases artist;

  const ReleasesView({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Row(
          children: [
          if (artist.coverImage != null)
      ClipOval(
    child: Image.network(
    artist.coverImage!,
      width: 40,
      height: 40,
      fit: BoxFit.cover,
    ),
    ),
    const SizedBox(width: 8), // Add some spacing between the image and the title
    Text(artist.title),
    ],
          ),
          ),
          // add space
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          BlocBuilder<DiscogsReleasesCubit, DiscogsReleasesState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const SliverToBoxAdapter(
                  child: Center(child: CupertinoActivityIndicator()),
                );
              } else if (state.error != null) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Error: ${state.error}',
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                    ),
                  ),
                );
              } else if (state.releases.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'No releases found',
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                    ),
                  ),
                );
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final music = state.releases[index];
                      return CupertinoListTile(
                        //add music.year.toString() to the title
                        title: Text(music.title),
                        subtitle: Text(music.year.toString()),
                        trailing: const Icon(
                          CupertinoIcons.link_circle,
                          color: CupertinoColors.systemGrey,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => LinksScreen(musicName: music.title),
                            ),
                          );
                        },
                      );
                    },
                    childCount: state.releases.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}