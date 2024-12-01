class Lesson {
  final String name;
  final String lesson;

  Lesson({
    required this.name,
    required this.lesson,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      name: json['name'] ?? '',
      lesson: json['lesson'] ?? '',
    );
  }
}

class ChapterWithLessons {
  final String name;
  final String title;
  final List<Lesson> lessons;

  ChapterWithLessons({
    required this.name,
    required this.title,
    required this.lessons,
  });

  factory ChapterWithLessons.fromJson(Map<String, dynamic> json) {
    final lessonsData = json['lessons'] as List<dynamic>? ?? [];
    return ChapterWithLessons(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      lessons: lessonsData.map((lessonJson) => Lesson.fromJson(lessonJson)).toList(),
    );
  }
}
