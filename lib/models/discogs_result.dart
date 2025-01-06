class DiscogsReleases {
  final String type;
  final int id;
  final String title;
  final String cover_image;

  DiscogsReleases({
    required this.type,
    required this.id,
    required this.title,
    required this.cover_image,
  });

  factory DiscogsReleases.fromJson(Map<String, dynamic> json) {
    return DiscogsReleases(
      type: json['type'],
      id: json['id'],
      title: json['title'],
      cover_image: json['cover_image'],

    );
  }
}