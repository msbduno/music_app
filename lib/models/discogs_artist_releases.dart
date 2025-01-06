class DiscogsArtistReleases {
  final String title;
  final int year;
  final int masterReleaseId;

  DiscogsArtistReleases({
    required this.title,
    required this.year,
    required this.masterReleaseId,
  });

  factory DiscogsArtistReleases.fromJson(Map<String, dynamic> json) {
    return DiscogsArtistReleases(
      title: json['title'],
      year: json['year'] ?? 0,
      masterReleaseId: json['id'],
    );
  }
}