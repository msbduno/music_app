import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/discogs_search_cubit.dart';
import '../models/discogs_releases.dart';

class RecentSearchesService {
  static const String _prefsKey = 'recent_searches';
  final SharedPreferences _prefs;
  final int _maxItems;
  final DiscogsSearchCubit _discogsSearchCubit;

  RecentSearchesService(this._prefs, this._discogsSearchCubit, {int maxItems = 4})
      : _maxItems = maxItems;

  List<String> getRecentSearches() {
    final String? searchesJson = _prefs.getString(_prefsKey);
    if (searchesJson == null) return [];
    return List<String>.from(jsonDecode(searchesJson));
  }

  Future<void> addSearch(String artistName) async {
    List<String> searches = getRecentSearches();
    // Remove if already exists
    searches.remove(artistName);
    // Add at the beginning
    searches.insert(0, artistName);
    // Keep only max items
    if (searches.length > _maxItems) {
      searches = searches.sublist(0, _maxItems);
    }

    await _prefs.setString(_prefsKey, jsonEncode(searches));
  }

  Future<List<DiscogsReleases>> loadRecentArtists() async {
    final searches = getRecentSearches();
    List<DiscogsReleases> results = [];

    for (String artistName in searches) {
      try {
        await _discogsSearchCubit.searchArtists(artistName);
        final state = _discogsSearchCubit.state;
        if (state.results.isNotEmpty) {
          results.add(state.results.first);
        }
      } catch (e) {
        print('Error loading artist $artistName: $e');
      }
    }

    return results;
  }

  Future<void> clearSearches() async {
    await _prefs.remove(_prefsKey);
  }
}