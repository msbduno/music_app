import 'package:music_app/models/discogs_result.dart';

class DiscogsSearchState {
  final List<DiscogsResult> results;
  final String? error;
  final bool isLoading;

  DiscogsSearchState({
    this.results = const [],
    this.error,
    this.isLoading = false,
  });
}