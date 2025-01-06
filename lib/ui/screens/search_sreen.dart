import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/discogs_result.dart';
import '../../repositories/discogs_repository.dart';
import '../widgets/history_widget.dart';
import '../widgets/search_result_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final List<String> _searchHistory = [];
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

    // Add a listener for real-time search
    _searchController.addListener(_onSearchChanged);
  }

  void _deleteFromHistory(String query) {
    setState(() {
      _searchHistory.remove(query);
    });
  }

  void _onSearchChanged() {
    if (_searchController.text.length >= 3) {
      _navigateToSearchResults(_searchController.text);
    }
  }

  void _navigateToSearchResults(String query) async {
    if (query.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
        final results = await _repository.fetchArtistData(query);
        setState(() {
          _searchResults = results;
          _isLoading = false;
        });

        // Add to history only if results are found and user navigates to details
        if (results.isNotEmpty) {
          if (!_searchHistory.contains(query)) {
            setState(() {
              _searchHistory.insert(0, query);
              if (_searchHistory.length > 10) {
                _searchHistory.removeLast();
              }
            });
          }
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
          _searchResults = [];
        });
        print('Search error: $e');
      }
    }
  }

  List<String> get filteredHistory {
    return _searchHistory
        .where((history) => history.toLowerCase().contains(_searchController.text.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _searchFocusNode.unfocus();
      },
      child: CupertinoPageScaffold(
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
                  focusNode: _searchFocusNode,
                  onChanged: (value) {
                    setState(() {});
                  },
                  placeholder: 'Search for an artist',
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
                  child: CupertinoActivityIndicator(),
                )
              else if (_searchController.text.isNotEmpty)
                Expanded(
                  child: SearchResultsWidget(searchResults: _searchResults),
                )
              else
                Expanded(
                  child: SearchHistoryWidget(
                    filteredHistory:filteredHistory,
                    searchController: _searchController,
                    navigateToSearchResults: _navigateToSearchResults,
                    deleteFromHistory: _deleteFromHistory
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}