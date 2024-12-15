// Model for Quiz API Response
class QuizResponse {
  final String name;
  final String title;
  final int totalMarks;
  final double duration;
  final List<QuizQuestion> questions;

  QuizResponse({
    required this.name,
    required this.title,
    required this.totalMarks,
    required this.questions,
    required this.duration
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      name: json['name'],
      title: json['title'],
      totalMarks: json['total_marks'],
      duration: json['duration'],
      questions: (json['questions'] as List)
          .map((question) => QuizQuestion.fromJson(question))
          .toList(),
    );
  }
}

class QuizQuestion {
  final String questionId;
  final String questionDetail;
  final int marks;

  QuizQuestion({
    required this.questionId,
    required this.questionDetail,
    required this.marks,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      questionId: json['question'],
      questionDetail: json['question_detail'],
      marks: json['marks'],
    );
  }
}

// Model for Question Details Response
class QuestionDetails {
  final String question;
  final List<Option> options;
  final bool multiple; // New field

  QuestionDetails({
    required this.question,
    required this.options,
    required this.multiple,
  });

factory QuestionDetails.fromJson(Map<String, dynamic> json) {
  final options = <Option>[];

  for (int i = 1; i <= 4; i++) {
    print('Parsing option_$i');
    final optionText = json['message']['option_$i'];
    final isCorrect = json['message']['is_correct_$i'] == 1;
    final explanation = json['message']['explanation_$i'];

    print('option_$i: $optionText, isCorrect: $isCorrect, explanation: $explanation');

    if (optionText != null) {
      options.add(Option(
        text: optionText,
        isCorrect: isCorrect,
        explanation: explanation,
      ));
    }
  }

  return QuestionDetails(
    question: json['message']['question'] ?? '',
    multiple: json['message']['multiple'] == 1,
    options: options,
  );
}

}

class Option {
  final String text;
  final bool isCorrect;
  final String? explanation;

  Option({
    required this.text,
    required this.isCorrect,
    this.explanation,
  });
}