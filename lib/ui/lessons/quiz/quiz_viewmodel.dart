import 'dart:async';
import 'dart:convert';
import 'package:education_media/ui/lessons/quiz/quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;


class QuizViewModel extends ChangeNotifier {
  late QuizResponse quiz;
  QuestionDetails? currentQuestionDetails;
  int currentQuestionIndex = 0;
  String? selectedOption;
  bool isAnswered = false;
  bool isCorrect = false;
    bool isSubmitted = false; // New state for submission

  List<Map<String, dynamic>> results = [];

int remainingTime= 0; // Time elapsed in seconds
  Timer? _timer;

  // Start the timer
 void startTimer(BuildContext context)async{
    if(remainingTime<=0)return;
         
_timer=Timer.periodic(const Duration(seconds: 1), (timer){
  if(remainingTime>0){
    remainingTime--;
    notifyListeners();
  }else{
    timer.cancel();
    submitQuiz(context);
  }
});
 }
  // Fetch quiz and first question details
  Future<void> loadQuiz(String? quizname,BuildContext context) async {
    try {
      final fetchedQuiz = await fetchQuiz(quizname!);
      quiz = fetchedQuiz;

      if(remainingTime>0){
       remainingTime = (quiz.duration * 60).toInt(); // Convert duration to seconds
      startTimer(context); 

      }else{
         remainingTime = 0;
      }
      
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

 results.add({
      "question_name": quiz.questions[currentQuestionIndex].questionId,
      "answer": selectedOption!,
      "is_correct": [isCorrect ? 1 : 0],
    });
    notifyListeners();
  }

  // Load next question
 


Future<void> nextQuestion() async {
    if (currentQuestionIndex < quiz.questions.length - 1) {
      currentQuestionIndex++;
      resetQuestionState();
      await loadQuestionDetails(quiz.questions[currentQuestionIndex].questionId);
      notifyListeners();
    }
  }

Future<void> submitQuiz(BuildContext context) async {
  final Uri url = Uri.parse(
        'https://peproprep.edusuite.store/api/method/peproprep.peproprep.api.extress.quiz_summary');
    String credentials = "token 6e874616bdffac3:59a589ce127cc2a";
   final headers = {
      "Authorization": " $credentials",
      "x-secret-key": credentials,
      'Accept': 'application/json',
      "Content-Type": "application/json",
    };

    final body = {
      "quiz": quiz.name,
      "results": results,
    };
 final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
  if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final message = responseData['message'];

      final score = message['score'];
      final scoreOutOf = message['score_out_of'];
      final percentage = message['percentage'];

      // Show success popup
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Quiz Submitted!'),
          content: Text(
              'You got $percentage% correct answers with a score of $score out of $scoreOutOf.'),
          actions: [
            TextButton(
              onPressed: () {

              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      throw Exception('Failed to submit quiz');
    }
  }
  void resetQuestionState() {
    isAnswered = false;
    isCorrect = false;
    selectedOption = null;
  }


String parseHtmlstring(String htmlstring){
  final document=parse(htmlstring);
  return document.body?.text??"";
}
@override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }
  // Submit quiz (dummy implementation for now)
  // Future<void> submitQuiz() async {
  //   print('Quiz submitted!');
  //   // Implement submission logic here if needed
  // }
}
