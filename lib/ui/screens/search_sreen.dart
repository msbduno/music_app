import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/ui/screens/search_details_screen.dart';

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

  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearching = _searchFocusNode.hasFocus;
      });
    });
  }

  void _navigateToSearchResults(String query) {
    if (query.isNotEmpty) {
      if (!_searchHistory.contains(query)) {
        setState(() {
          _searchHistory.insert(0, query);
          if (_searchHistory.length > 10) {
            _searchHistory.removeLast();
          }
        });
      }
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => SearchDetailsScreen(query: query),
        ),
      );
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
            if (_searchController.text.isNotEmpty)
              Expanded(
                child: _buildSearchHistory(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHistory() {
    final filteredHistory = _searchHistory
        .where((item) =>
        item.toLowerCase().contains(_searchController.text.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredHistory.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Remplir le champ de recherche et naviguer
            _searchController.text = filteredHistory[index];
            _navigateToSearchResults(filteredHistory[index]);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: CupertinoColors.systemGrey4,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.clock,
                  color: CupertinoColors.systemGrey,
                ),
                const SizedBox(width: 10),
                Text(
                  filteredHistory[index],
                  style: const TextStyle(
                    color: CupertinoColors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}

