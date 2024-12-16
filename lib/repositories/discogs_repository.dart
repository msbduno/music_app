import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/models/discogs_result.dart';

class DiscogsRepository {
  final String _baseUrl = 'https://api.discogs.com/database/search';
  final String _token = 'txaGrjCJfcRnduXfGTWIDKuqDroIIKeeyIrPerzn';

  Future<List<DiscogsResult>> fetchArtistData(String artistName) async {
    final response = await http.get(Uri.parse('$_baseUrl?artist=$artistName&token=$_token'));

    if (response.statusCode == 200) {
      final List<dynamic> resultsJson = json.decode(response.body)['results'];
      return resultsJson.map((json) => DiscogsResult.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load artist data');
    }
  }
}