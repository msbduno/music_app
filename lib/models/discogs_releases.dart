class DiscogsReleases {
  final String type;
  final int id;
  final String title;
  final String? coverImage;

  DiscogsReleases({
    required this.type,
    required this.id,
    required this.title,
    this.coverImage,
  });

  factory DiscogsReleases.fromJson(Map<String, dynamic> json) {
    return DiscogsReleases(
      type: json['type'],
      id: json['id'],
      title: json['title'],
      coverImage: json['cover_image'],
    );
  }
}