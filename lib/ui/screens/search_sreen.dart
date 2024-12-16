import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/ui/screens/search_details_screen.dart';

import '../../models/discogs_result.dart';
import '../../repositories/discogs_repository.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final List<String> _searchHistory = [
    'Daft Punk',
    'The Weeknd',
    'Coldplay',
    'Ed Sheeran',
    'Billie Eilish'
  ];
  final DiscogsRepository _repository = DiscogsRepository();
  bool _isSearching = false;
  bool _isLoading = false;
  List<DiscogsResult> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearching = _searchFocusNode.hasFocus;
      });
    });
  }

  void _navigateToSearchResults(String query) async {
    if (query.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      if (!_searchHistory.contains(query)) {
        setState(() {
          _searchHistory.insert(0, query);
          if (_searchHistory.length > 10) {
            _searchHistory.removeLast();
          }
        });
      }
      final results = await _repository.fetchArtistData(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Search'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoSearchTextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: _navigateToSearchResults,
                placeholder: 'Search for music / artist',
                suffixIcon: _searchController.text.isNotEmpty
                    ? const Icon(CupertinoIcons.clear_circled_solid)
                    : const Icon(CupertinoIcons.search),
                onSuffixTap: () {
                  _searchController.clear();
                  setState(() {});
                },
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (_searchController.text.isNotEmpty)
              Expanded(
                child: _buildSearchResults(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Text('No results found'),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return Material(
          child: ListTile(
            title: Text(result.concatenatedTitle),
            subtitle: Text(result.genre.join(', ')),
          ),
        );
      },
    );
  }
}