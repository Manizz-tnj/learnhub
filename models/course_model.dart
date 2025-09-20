

// models/course_model.dart
class Course {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int totalLessons;
  final int completedLessons;
  final List<Lesson> lessons;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.totalLessons,
    this.completedLessons = 0,
    required this.lessons,
  });
}

class Lesson {
  final String id;
  final String title;
  final String content;
  final bool isCompleted;

  Lesson({
    required this.id,
    required this.title,
    required this.content,
    this.isCompleted = false,
  });
}
