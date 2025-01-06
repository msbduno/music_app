import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/models/discogs_result.dart';

import '../models/discogs_artist_releases.dart';

class DiscogsRepository {
  final String _baseSearchUrl = 'https://api.discogs.com/database/search';
  final String _baseArtistUrl = 'https://api.discogs.com/artists';
  final String _token = 'txaGrjCJfcRnduXfGTWIDKuqDroIIKeeyIrPerzn';

  Future<List<DiscogsReleases>> fetchArtistData(String artistName) async {
    final response = await http.get(Uri.parse('$_baseSearchUrl?q=$artistName&type=artist&token=$_token'));

    if (response.statusCode == 200) {
      final List<dynamic> resultsJson = json.decode(response.body)['results'];

      final Set<String> uniqueTitles = {};
      final List<DiscogsReleases> uniqueResults = [];

      for (var result in resultsJson) {
        if (uniqueTitles.add(result['title'])) {
          uniqueResults.add(DiscogsReleases.fromJson(result));
        }
      }

      return uniqueResults;
    } else {
      throw Exception('Failed to load artist data');
    }
  }

  Future<List<DiscogsArtistReleases>> fetchArtistReleases(int artistId) async {
    List<DiscogsArtistReleases> allReleases = [];
    int currentPage = 1;
    int totalPages = 1;

    do {
      final response = await http.get(
          Uri.parse('$_baseArtistUrl/$artistId/releases?token=$_token&page=$currentPage')
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final List<dynamic> releasesJson = responseBody['releases'];
        totalPages = responseBody['pagination']['pages'];

        for (var releaseJson in releasesJson) {
          print(releaseJson);
          allReleases.add(DiscogsArtistReleases.fromJson(releaseJson));
        }

        currentPage++;
      } else {
        throw Exception('Failed to load artist releases');
      }
    } while (currentPage <= totalPages);

    return allReleases;
  }
}