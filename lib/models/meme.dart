class Meme {
  final String id;
  final String name;
  final String url;

  Meme({required this.id, required this.name, required this.url});

  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }
}
