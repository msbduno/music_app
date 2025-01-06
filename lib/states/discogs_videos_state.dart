import 'package:music_app/models/discogs_videos.dart';

class DiscogsVideosState {
  final Map<String, List<DiscogsVideos>> videos;
  final String? error;
  final bool isLoading;

  DiscogsVideosState({
    this.videos = const {},
    this.error,
    this.isLoading = false,
  });
}