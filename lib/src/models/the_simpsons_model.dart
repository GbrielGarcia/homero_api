class TheSimpsonsModels {
  final String quote;
  final String character;
  final String image;

  TheSimpsonsModels(
    this.quote,
    this.character,
    this.image,
  );
  factory TheSimpsonsModels.fromMap(Map<String, dynamic> json) {
    return TheSimpsonsModels(
      json['quote'],
      json['character'],
      json['image'],
    );
  }
  factory TheSimpsonsModels.fromJson(Map<String, dynamic> json) {
    return TheSimpsonsModels(
      json['quote'],
      json['character'],
      json['image'],
    );
  }
}
