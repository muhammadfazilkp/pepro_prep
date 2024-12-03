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

import 'package:education_media/ui/lessons/quiz/quiz_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart'; // Import the stacked package for ViewModelBuilder

class QuizPage extends StatelessWidget {
  final String quizName;

  const QuizPage({Key? key, required this.quizName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuizViewModel>.reactive(
      viewModelBuilder: () => QuizViewModel()..loadQuiz(quizName),
      builder: (context, viewModel, child) {
        if (viewModel.currentQuestionDetails == null) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final questionDetails = viewModel.currentQuestionDetails!;
        final quiz = viewModel.quiz;
        final mediaQuery=MediaQuery.of(context);
 final double height = mediaQuery.size.height * 0.47; 
  final double width = mediaQuery.size.width * 0.9;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Quiz'),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              children: [
                
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 0.5),borderRadius: BorderRadius.circular(12)),
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
                            color: Colors.grey
                          ),
                        ),
                         Text(
                            '${quiz.questions[viewModel.currentQuestionIndex].marks} Marks',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],),
                      )
                     ,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 27),
                              child: Text(
                                questionDetails.question,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                         
                          ],
                        ),
                      ),
                      // Marks
                    
                      ...questionDetails.options.map((option) {
                         return Padding(
  padding: const EdgeInsets.all(10),
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(width: 0.3),
      borderRadius: BorderRadius.circular(8),
            color: Colors.grey[100], // Set the desired grey color
 // Set the desired radius
    ),
    child: RadioListTile<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Match the radius here
      ),
      title: Text(option.text),
      value: option.text,
      groupValue: viewModel.selectedOption,
      onChanged: viewModel.isAnswered
          ? null
          : (value) {
              viewModel.selectedOption = value;
              viewModel.notifyListeners();
            },
    ),
  ),
);

                      }).toList(),
                      const SizedBox(height: 20),
                      // Check or Submit Button
                      if (!viewModel.isAnswered)
                        ElevatedButton(
                          onPressed: viewModel.selectedOption == null
                              ? null
                              : () => viewModel.checkAnswer(),
                          child: const Text('Check'),
                        ),
                      if (viewModel.isAnswered)
                        Column(
                          children: [
                            // Feedback on Answer
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
                            // Next Question or Submit Quiz
                            ElevatedButton(
                              onPressed: viewModel.currentQuestionIndex <
                                      quiz.questions.length - 1
                                  ? () => viewModel.nextQuestion()
                                  : () => viewModel.submitQuiz(),
                              child: Text(
                                viewModel.currentQuestionIndex <
                                        quiz.questions.length - 1
                                    ? 'Next Question'
                                    : 'Submit Quiz',
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
