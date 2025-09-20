class Question {
  final String id;
  final String question;
  final List<Option> options;
  final String correctOptionId;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionId,
  });
}

class Option {
  final String id;
  final String text;

  Option({
    required this.id,
    required this.text,
  });
}

class Quiz {
  final String id;
  final String title;
  final String courseId;
  final List<Question> questions;
  final int timeInMinutes;

  Quiz({
    required this.id,
    required this.title,
    required this.courseId,
    required this.questions,
    required this.timeInMinutes,
  });
}