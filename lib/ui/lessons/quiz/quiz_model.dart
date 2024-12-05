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
  final String type;
    final int multiple; // New field to represent if it's a multiple-choice question

  final List<Option> options;

  QuestionDetails({
    required this.question,
    required this.type,
    required this.options,
    required this.multiple
  });

  factory QuestionDetails.fromJson(Map<String, dynamic> json) {
    return QuestionDetails(
      question: json['message']['question'],
      type: json['message']['type'],
      multiple: json['multiple']??0,
      options: [
        if (json['message']['option_1'] != null)
          Option(
            text: json['message']['option_1'],
            isCorrect: json['message']['is_correct_1'] == 1,
          ),
        if (json['message']['option_2'] != null)
          Option(
            text: json['message']['option_2'],
            isCorrect: json['message']['is_correct_2'] == 1,
          ),
        if (json['message']['option_3'] != null)
          Option(
            text: json['message']['option_3'],
            isCorrect: json['message']['is_correct_3'] == 1,
          ),
        if (json['message']['option_4'] != null)
          Option(
            text: json['message']['option_4'],
            isCorrect: json['message']['is_correct_4'] == 1,
          ),
      ],
    );
  }
}

class Option {
  final String text;
  final bool isCorrect;

  Option({
    required this.text,
    required this.isCorrect,
  });
}
