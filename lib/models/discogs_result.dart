class DiscogsResult {
  final String type;
  final List<String> genre;
  final List<String> style;
  final int id;
  final String title;

  DiscogsResult({
    required this.type,
    required this.genre,
    required this.style,
    required this.id,
    required this.title,
  });

  factory DiscogsResult.fromJson(Map<String, dynamic> json) {
    return DiscogsResult(
      type: json['type'],
      genre: List<String>.from(json['genre']),
      style: List<String>.from(json['style']),
      id: json['id'],
      title: json['title'],
    );
  }
}