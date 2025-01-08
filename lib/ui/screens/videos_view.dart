import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/discogs_videos_cubit.dart';
import '../../repositories/discogs_repository.dart';
import '../../states/discogs_videos_state.dart';
import '../../models/discogs_artist_releases.dart';
import '../widgets/video_player_widget.dart';

class VideosUi extends StatelessWidget {
  final DiscogsArtistReleases release;

  const VideosUi({super.key, required this.release});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscogsVideosCubit(DiscogsRepository())..searchArtistsVideos(release.masterReleaseId),
      child: VideosView(release: release),
    );
  }
}

class VideosView extends StatelessWidget {
  final DiscogsArtistReleases release;

  const VideosView({super.key, required this.release});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Row(
              children: [
                Text(release.title),
                const SizedBox(width: 8),
                Text(
                  '(${release.year})',
                  style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                    color: CupertinoColors.systemGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          BlocBuilder<DiscogsVideosCubit, DiscogsVideosState>(
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
              } else if (state.videos.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'No videos found',
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                    ),
                  ),
                );
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final videoEntry = state.videos.entries.elementAt(index);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              videoEntry.key,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ...videoEntry.value.map((video) => VideoPlayerWidget(uri: video.uri)),
                        ],
                      );
                    },
                    childCount: state.videos.length,
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


