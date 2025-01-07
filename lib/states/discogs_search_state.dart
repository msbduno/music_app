import 'package:music_app/models/discogs_releases.dart';

class DiscogsSearchState {
  final List<DiscogsReleases> results;
  final String? error;
  final bool isLoading;

  DiscogsSearchState({
    this.results = const [],
    this.error,
    this.isLoading = false,
  });

}