// lib/ui/widgets/search_results_widget.dart
import 'package:flutter/cupertino.dart';
import 'package:music_app/models/discogs_result.dart';
import 'package:music_app/ui/screens/search_details_screen.dart';

class SearchResultsWidget extends StatelessWidget {
  final List<DiscogsReleases> searchResults;

  const SearchResultsWidget({
    super.key,
    required this.searchResults,
  });

  @override
  Widget build(BuildContext context) {
    if (searchResults.isEmpty) {
      return Center(
        child: Text(
          'Aucun résultat trouvé',
          style: CupertinoTheme.of(context).textTheme.textStyle,
        ),
      );
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final result = searchResults[index];
        return CupertinoListTile(
          title: Text(result.title),
          onTap: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => SearchDetailsScreen(artist: result),
              ),
            );
          },
        );
      },
    );
  }
}