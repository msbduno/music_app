import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/service/recent_researh_service.dart';
import '../../blocs/recent_artists_cubit.dart';
import '../../states/recent_artists_state.dart';
import 'releases_view.dart';

class HomeUi extends StatelessWidget {
  final RecentSearchesService searchesService;

  const HomeUi({super.key, required this.searchesService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecentArtistsCubit(searchesService)..loadRecentArtists(),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Music App'),
        backgroundColor: Color(0xFFB4EDD2),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Recent Searches',
                style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
              ),
            ),
            BlocBuilder<RecentArtistsCubit, RecentArtistsState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (state.error != null) {
                  return Center(child: Text('Error: ${state.error}'));
                } else if (state.artists.isEmpty) {
                  return const Center(child: Text(''));
                } else {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.5,
                        ),
                        itemCount: state.artists.length,
                        itemBuilder: (context, index) {
                          final artist = state.artists[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => ReleasesUi(artist: artist),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemBackground,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: CupertinoColors.systemGrey.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    CupertinoIcons.music_note_2,
                                    size: 32,
                                    color: Color(0xFFB4EDD2),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      artist.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}