class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex; // 0, 1, 2, 3

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class QuizTopic {
  final String id;
  final String title;
  final String iconEmoji;
  final List<QuizQuestion> questions;

  QuizTopic({
    required this.id,
    required this.title,
    required this.iconEmoji,
    required this.questions,
  });
}
