class Chapter {
  final String name;

  Chapter({required this.name});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      name: json['name'] ?? '',
    );
  }
}
