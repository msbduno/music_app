import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:music_app/blocs/discogs_search_cubit.dart';
import 'package:music_app/repositories/discogs_repository.dart';
import 'package:music_app/ui/screens/releases_view.dart';
import '../../service/recent_researh_service.dart';
import '../../states/discogs_search_state.dart';

class SearchUi extends StatelessWidget {
  final RecentSearchesService searchesService;

  const SearchUi({super.key, required this.searchesService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RecentSearchesService>.value(value: searchesService),
        BlocProvider(
          create: (context) => DiscogsSearchCubit(DiscogsRepository()),
        ),
      ],
      child: const SearchView(),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Search'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CupertinoSearchTextField(
              onSubmitted: (value) {
                context.read<DiscogsSearchCubit>().searchArtists(value);
              },
            ),
            BlocBuilder<DiscogsSearchCubit, DiscogsSearchState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const CupertinoActivityIndicator();
                } else if (state.error != null) {
                  return const Text('Error');
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.results.length,
                      itemBuilder: (context, index) {
                        final result = state.results[index];
                        return CupertinoListTile(
                          title: Text(result.title),
                          //subtitle: Text(result.genre.join(', ')),
                          onTap: () async {
                            final searchService = context.read<RecentSearchesService>();
                            await searchService.addSearch(result.title);
                            if (context.mounted) {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => ReleasesUi(artist: result),
                                ),
                              );
                            }
                          },
                        );
                      },
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