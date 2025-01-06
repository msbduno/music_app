import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/models/discogs_result.dart';

class DiscogsRepository {
  final String _baseSearchUrl = 'https://api.discogs.com/database/search';
  final String _baseArtistUrl = 'https://api.discogs.com/artists';
  final String _token = 'txaGrjCJfcRnduXfGTWIDKuqDroIIKeeyIrPerzn';

  Future<List<DiscogsResult>> fetchArtistData(String artistName) async {
    print('Fetching artist data for: $artistName');
    final response = await http.get(Uri.parse('$_baseSearchUrl?artist=$artistName&token=$_token'));

    if (response.statusCode == 200) {
      final List<dynamic> resultsJson = json.decode(response.body)['results'];
      print('Initial search results: ${resultsJson.length} items found');

      final Set<String> uniqueTitles = {};
      final List<DiscogsResult> uniqueResults = [];

      for (var result in resultsJson) {
        final concatenatedTitle = result['title'].split(' - ')[0];
        if (uniqueTitles.add(concatenatedTitle)) {
          uniqueResults.add(DiscogsResult.fromJson(result));
        }
      }

      print('Total unique results found: ${uniqueResults.length}');
      return uniqueResults;
    } else {
      print('Failed to fetch initial search results');
      throw Exception('Failed to load artist data');
    }
  }

  Future<List> fetchArtistReleases(int artistId) async {
    print('Fetching releases for artist ID: $artistId');
    final response = await http.get(
        Uri.parse('$_baseArtistUrl/$artistId/releases?token=$_token')
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final List<dynamic> releases = responseBody['releases'];

      // Extraire les titres des releases
      final List releaseTitles = releases.map((release) {
        return release['title'] ?? 'Unknown Release';
      }).toList();

      print('Found ${releaseTitles.length} releases');
      return releaseTitles;
    } else {
      print('Failed to fetch artist releases');
      throw Exception('Failed to load artist releases');
    }
  }
}