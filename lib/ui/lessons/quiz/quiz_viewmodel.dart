import 'dart:convert';
import 'package:education_media/ui/lessons/quiz/quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class QuizViewModel extends ChangeNotifier {
  late QuizResponse quiz;
  QuestionDetails? currentQuestionDetails;
  int currentQuestionIndex = 0;
  String? selectedOption;
  bool isAnswered = false;
  bool isCorrect = false;


  // Fetch quiz and first question details
  Future<void> loadQuiz(String? quizname) async {
    try {
      final fetchedQuiz = await fetchQuiz(quizname!);
      quiz = fetchedQuiz;
      await loadQuestionDetails(fetchedQuiz.questions.first.questionId);
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to load quiz: $error');
    }
  }

  Future<QuizResponse> fetchQuiz(String quizName) async {
        String encodedChapterName=Uri.encodeComponent(quizName);


    final encodedPath =
        'https://peproprep.edusuite.store/api/resource/LMS%20Quiz/$encodedChapterName';

        final Uri url=Uri.parse(encodedPath);
       String credentials = "token 6e874616bdffac3:59a589ce127cc2a";

        
      final headers = {
        "Authorization": " $credentials",
        "x-secret-key": credentials,
        'Accept': 'application/json',
        "Content-Type": "application/json",
      };
    final response = await http.get(url,headers: headers);
print(response.body);
    if (response.statusCode == 200) {
      return QuizResponse.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to load quiz');
    }
  }

  // Fetch question details from API
  Future<void> loadQuestionDetails(String questionId) async {
    final url =
        'https://peproprep.edusuite.store/api/method/lms.lms.utils.get_question_details';
               String credentials = "token 6e874616bdffac3:59a589ce127cc2a";

           final headers = {
        "Authorization": " $credentials",
        "x-secret-key": credentials,
        'Accept': 'application/json',
        "Content-Type": "application/json",
      };
    final response = await http.post(
      Uri.parse('$url?question=$questionId'),
      
      headers: headers
    );
print(response.body);
    if (response.statusCode == 200) {
      currentQuestionDetails =
          QuestionDetails.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load question details');
    }
  }

  // Check answer correctness
  void checkAnswer() {
    if (selectedOption == null) return;

    isAnswered = true;
    isCorrect = currentQuestionDetails!.options
        .firstWhere((option) => option.text == selectedOption!)
        .isCorrect;
    notifyListeners();
  }

  // Load next question
  Future<void> nextQuestion() async {
    if (currentQuestionIndex < quiz.questions.length - 1) {
      currentQuestionIndex++;
      isAnswered = false;
      selectedOption = null;

      await loadQuestionDetails(quiz.questions[currentQuestionIndex].questionId);
      notifyListeners();
    }
  }

  // Submit quiz (dummy implementation for now)
  Future<void> submitQuiz() async {
    print('Quiz submitted!');
    // Implement submission logic here if needed
  }
}
