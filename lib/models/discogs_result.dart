class DiscogsResult {
  final String type;
  final int id;
  final String title;
  final String cover_image;

  DiscogsResult({
    required this.type,
    required this.id,
    required this.title,
    required this.cover_image,
  });

  factory DiscogsResult.fromJson(Map<String, dynamic> json) {
    return DiscogsResult(
      type: json['type'],
      id: json['id'],
      title: json['title'],
      cover_image: json['cover_image'],

    );
  }
}