import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import '../models/spotify_model.dart';

class SpotifyRepository {
  static const String _clientId = '35aad5054b174777af4949b0e6f3c384';
  static const String _clientSecret = 'e2cead9b89b145be901916a3d7e118ad';
  static const String _redirectUri = 'music.app.bundle:/oauth-callback';

  final _storage = const FlutterSecureStorage();

  String _getAuthorizationUrl() {
    final params = {
      'client_id': _clientId,
      'response_type': 'code',
      'redirect_uri': _redirectUri,
      'scope': 'user-read-private user-read-email streaming',
      'show_dialog': 'true'
    };

    final queryString = params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');

    return 'https://accounts.spotify.com/authorize?$queryString';
  }

  Future<String?> authenticate() async {
    try {
      final result = await FlutterWebAuth.authenticate(
          url: _getAuthorizationUrl(),
          callbackUrlScheme: 'your.app.bundle'
      );

      final code = Uri.parse(result).queryParameters['code'];

      if (code == null) {
        throw 'Échec de l\'authentification';
      }

      final tokenResponse = await http.post(
        Uri.parse('https://accounts.spotify.com/api/token'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic ${base64Encode(utf8.encode('$_clientId:$_clientSecret'))}',
        },
        body: {
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': _redirectUri,
        },
      );

      final tokenData = json.decode(tokenResponse.body);

      await _storage.write(key: 'access_token', value: tokenData['access_token']);
      await _storage.write(key: 'refresh_token', value: tokenData['refresh_token']);

      return tokenData['access_token'];
    } catch (e) {
      print('Erreur d\'authentification : $e');
      return null;
    }
  }

  Future<String?> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refresh_token');

    if (refreshToken == null) return null;

    try {
      final response = await http.post(
        Uri.parse('https://accounts.spotify.com/api/token'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic ${base64Encode(utf8.encode('$_clientId:$_clientSecret'))}',
        },
        body: {
          'grant_type': 'refresh_token',
          'refresh_token': refreshToken,
        },
      );

      final tokenData = json.decode(response.body);
      await _storage.write(key: 'access_token', value: tokenData['access_token']);

      return tokenData['access_token'];
    } catch (e) {
      print('Erreur de rafraîchissement du token : $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    String? accessToken = await _storage.read(key: 'access_token');

    if (accessToken == null) {
      accessToken = await refreshToken();
      if (accessToken == null) return null;
    }

    try {
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/me'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      return json.decode(response.body);
    } catch (e) {
      print('Erreur de récupération du profil : $e');
      return null;
    }
  }

  Future<List<Track>> searchTracks(String query) async {
    String? accessToken = await _storage.read(key: 'access_token');

    if (accessToken == null) {
      accessToken = await refreshToken();
      if (accessToken == null) return [];
    }

    try {
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/search?q=${Uri.encodeComponent(query)}&type=track&limit=10'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      final data = json.decode(response.body);
      return (data['tracks']['items'] as List)
          .map((item) => Track.fromJson(item))
          .toList();
    } catch (e) {
      print('Erreur de recherche de morceaux : $e');
      return [];
    }
  }
}