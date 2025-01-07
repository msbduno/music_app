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
            backgroundColor: CupertinoColors.activeBlue,
            largeTitle: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      artist.title,
                      style: CupertinoTheme.of(context).textTheme.navTitleTextStyle.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                        title: Text(music.title),
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