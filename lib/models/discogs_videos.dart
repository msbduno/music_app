class DiscogsVideos {
  final String uri;
  final String title;
  final String description;
  final int duration;

  DiscogsVideos({
    required this.uri,
    required this.title,
    required this.description,
    required this.duration,
  });

  factory DiscogsVideos.fromJson(Map<String, dynamic> json) {
    return DiscogsVideos(
      uri: json['uri'],
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
    );
  }
}