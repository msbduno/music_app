class Track {
  final String id;
  final String name;
  final String artist;
  final String album;
  final String imageUrl;

  Track({
    required this.id,
    required this.name,
    required this.artist,
    required this.album,
    required this.imageUrl,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'],
      name: json['name'],
      artist: (json['artists'] as List).map((artist) => artist['name']).join(', '),
      album: json['album']['name'],
      imageUrl: json['album']['images'][0]['url'],
    );
  }
}