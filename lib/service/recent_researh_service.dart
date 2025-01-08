import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/discogs_releases.dart';
import '../blocs/discogs_search_cubit.dart';

class RecentSearchesService {
  static const String _prefsKey = 'recent_searches';
  final SharedPreferences _prefs;
  final int _maxItems;
  final DiscogsSearchCubit _discogsSearchCubit;

  RecentSearchesService(this._prefs, this._discogsSearchCubit, {int maxItems = 6})
      : _maxItems = maxItems;

  List<String> getRecentSearches() {
    final String? searchesJson = _prefs.getString(_prefsKey);
    if (searchesJson == null) return [];
    return List<String>.from(jsonDecode(searchesJson));
  }

  Future<void> addSearch(String artistName) async {
    List<String> searches = getRecentSearches();
    searches.remove(artistName);
    searches.insert(0, artistName);
    if (searches.length > _maxItems) {
      searches = searches.sublist(0, _maxItems);
    }
    await _prefs.setString(_prefsKey, jsonEncode(searches));
  }

  Future<void> removeSearch(String artistName) async {
    List<String> searches = getRecentSearches();
    searches.remove(artistName);
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
}