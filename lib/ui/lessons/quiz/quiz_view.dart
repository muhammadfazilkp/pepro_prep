// import 'package:education_media/ui/lessons/quiz/quiz_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';

// class QuizPage extends StatelessWidget {
//   final String? quizName;

//   const QuizPage({Key? key, this.quizName}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<QuizViewModel>.reactive(viewModelBuilder:()=>QuizViewModel()..loadQuiz(quizName), 
//     builder: (context,model,child){
//       if (model.currentQuestionDetails == null) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             final questionDetails = model.currentQuestionDetails!;
//             final quiz = model.quiz;

//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     questionDetails.question,
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Text('Marks: ${quiz.questions[model.currentQuestionIndex].marks}'),
//                   const SizedBox(height: 20),
//                   ...questionDetails.options.map((option) {
//                     return RadioListTile<String>(
//                       title: Text(option.text),
//                       value: option.text,
//                       groupValue: model.selectedOption,
//                       onChanged: model.isAnswered
//                           ? null
//                           : (value) {
//                               model.selectedOption = value;
//                               model.notifyListeners();
//                             },
//                     );
//                   }).toList(),
//                   const SizedBox(height: 20),
//                   if (!model.isAnswered)
//                     ElevatedButton(
//                       onPressed: () => model.checkAnswer(),
//                       child: const Text('Check'),
//                     ),
//                   if (model.isAnswered)
//                     Column(
//                       children: [
//                         Text(
//                           model.isCorrect ? 'Correct!' : 'Incorrect!',
//                           style: TextStyle(
//                             color: model.isCorrect
//                                 ? Colors.green
//                                 : Colors.red,
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: model.currentQuestionIndex <
//                                   quiz.questions.length - 1
//                               ? () => model.nextQuestion()
//                               : () => model.submitQuiz(),
//                           child: Text(
//                             model.currentQuestionIndex <
//                                     quiz.questions.length - 1
//                                 ? 'Next Question'
//                                 : 'Submit Quiz',
//                           ),
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//             );
//     });
    
//      }}

// iimport 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'quiz_viewmodel.dart';

class QuizPage extends StatelessWidget {
  final String quizName;

  const QuizPage({Key? key, required this.quizName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuizViewModel>.reactive(
      viewModelBuilder: () => QuizViewModel()..loadQuiz(quizName, context),
      builder: (context, viewModel, child) {
        if (viewModel.currentQuestionDetails == null) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final questionDetails = viewModel.currentQuestionDetails!;
        final quiz = viewModel.quiz;
        final mediaQuery = MediaQuery.of(context);
        final double height = mediaQuery.size.height * 0.47;
        final double width = mediaQuery.size.width * 0.9;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Quiz'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.circular(12)),
                  height: height,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Question ${viewModel.currentQuestionIndex + 1} of ${quiz.questions.length}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                            Text(
                              '${quiz.questions[viewModel.currentQuestionIndex].marks} Marks',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${viewModel.parseHtmlstring(questionDetails.question)}?',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Render options based on question type
                      if (viewModel.isMultipleChoice)
                        Column(
                          children: questionDetails.options.map((option) {
                            return CheckboxListTile(
                              title: Text(option.text),
                              value: viewModel.selectedOptions
                                  .contains(option.text),
                              onChanged: (isChecked) {
                                viewModel.toggleOption(option.text);
                              },
                            );
                          }).toList(),
                        )
                      else
                        Column(
                          children: questionDetails.options.map((option) {
                            return RadioListTile<String>(
                              title: Text(option.text),
                              value: option.text,
                              groupValue: viewModel.selectedOption,
                              onChanged: viewModel.isAnswered
                                  ? null
                                  : (value) {
                                      viewModel.selectedOption = value;
                                      viewModel.notifyListeners();
                                    },
                            );
                          }).toList(),
                        ),
                      const SizedBox(height: 20),
                      // Check or Submit Button
                      ElevatedButton(
                        onPressed: viewModel.canCheckAnswer
                            ? () => viewModel.checkAnswer()
                            : null,
                        child: const Text('Check'),
                      ),
                      if (viewModel.isAnswered)
                        Column(
                          children: [
                            Text(
                              viewModel.isCorrect ? 'Correct!' : 'Incorrect!',
                              style: TextStyle(
                                color: viewModel.isCorrect
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: viewModel.currentQuestionIndex <
                                      quiz.questions.length - 1
                                  ? () => viewModel.nextQuestion()
                                  : () => viewModel.submitQuiz(context),
                              child: Text(
                                viewModel.currentQuestionIndex <
                                        quiz.questions.length - 1
                                    ? 'Next Question'
                                    : 'Submit Now',
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                LinearProgressIndicator(
                  value: quiz.duration > 0
                      ? viewModel.remainingTime / (quiz.duration * 60)
                      : 0.0,
                  minHeight: 5,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
