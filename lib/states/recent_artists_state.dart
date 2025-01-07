import '../models/discogs_result.dart';

class RecentArtistsState {
  final List<DiscogsReleases> artists;
  final String? error;
  final bool isLoading;

  RecentArtistsState({
    this.artists = const [],
    this.error,
    this.isLoading = false,
  });
}