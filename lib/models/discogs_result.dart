class DiscogsResult {
  final String type;
  final List<String> genre;
  final List<String> style;
  final int id;
  final String title;
  final String concatenatedTitle;

  DiscogsResult({
    required this.type,
    required this.genre,
    required this.style,
    required this.id,
    required this.title,
    required this.concatenatedTitle,
  });

  factory DiscogsResult.fromJson(Map<String, dynamic> json) {
    final title = json['title'] ?? '';
    final concatenatedTitle = title.split(' - ')[0];
    return DiscogsResult(
      type: json['type'],
      genre: List<String>.from(json['genre']),
      style: List<String>.from(json['style']),
      id: json['id'],
      title: title,
      concatenatedTitle: concatenatedTitle,
    );
  }
}