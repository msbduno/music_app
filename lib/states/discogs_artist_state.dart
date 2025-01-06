import '../models/discogs_artist_releases.dart';

class DiscogsReleasesState{
  final List<DiscogsArtistReleases> releases;
  final String? error;
  final bool isLoading;

  DiscogsReleasesState({
    this.releases = const [],
    this.error,
    this.isLoading = false,
  });
}