class Course {
  final String name;
  final String title;
  final String description;
  final String image;
  final String shortIntroduction;
  final String status;
  final int published;
  final int upcoming;
  final double rating;
  final List<Instructor> instructors;

  Course({
    required this.name,
    required this.title,
    required this.description,
    required this.image,
    required this.shortIntroduction,
    required this.status,
    required this.published,
    required this.upcoming,
    required this.rating,
    required this.instructors,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      shortIntroduction: json['short_introduction'] ?? '',
      status: json['status'] ?? '',
      published: json['published'] ?? 0,
      upcoming: json['upcoming'] ?? 0,
      rating: double.tryParse(json['rating'] ?? '0.0') ?? 0.0,
      instructors: (json['instructors'] as List<dynamic>?)
              ?.map((instructorJson) => Instructor.fromJson(instructorJson))
              .toList() ??
          [],
    );
  }
}

class Instructor {
  final String name;
  final String username;
  final String fullName;

  Instructor({
    required this.name,
    required this.username,
    required this.fullName,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      fullName: json['full_name'] ?? '',
    );
  }
}
