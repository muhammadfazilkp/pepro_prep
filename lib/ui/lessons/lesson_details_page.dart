// import 'dart:convert';

// import 'package:education_media/ui/lessons/lesson_veiw_model.dart';
// import 'package:education_media/widgets/pdf_view_page.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';

// class LessonDetailsPage extends StatelessWidget {
//   final String lessonName;

//   const LessonDetailsPage({Key? key, required this.lessonName}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<LessonDetailsViewModel>.reactive(
//       viewModelBuilder: () => LessonDetailsViewModel()..fetchLessonDetails(lessonName),
//       builder: (context, viewModel, child) {
//         if (viewModel.isLoading) {
//           return const Scaffold(
//             backgroundColor: Colors.white,
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         final lessonDetails = viewModel.lessonDetails;
//         if (lessonDetails == null) {
//           return const Scaffold(
//             body: Center(child: Text('Failed to load lesson details.')),
//           );
//         }

//         return Scaffold(
//           appBar: AppBar(title: Text(lessonDetails.title)),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   lessonDetails.title,
//                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(lessonDetails.body),
//                 const SizedBox(height: 16),
//                 lessonDetails.pdfFileUrl.isNotEmpty
//                 ? pdfView(context,'https://peproprep.edusuite.store${lessonDetails.pdfFileUrl}')
// :Text('Pdf file is empty')

//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:education_media/ui/catogory/catogory_view_model.dart';
import 'package:education_media/ui/lessons/quiz/quiz_view.dart';
import 'package:education_media/widgets/pdf_view_page.dart';
import 'package:flutter/material.dart';
import 'package:education_media/ui/lessons/lesson_veiw_model.dart';
import 'package:stacked/stacked.dart';

import '../video/video_view.dart';

class LessonDetailsPage extends StatelessWidget {
  final String lessonName;

  const LessonDetailsPage({Key? key, required this.lessonName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LessonDetailsViewModel>.reactive(
      viewModelBuilder: () =>LessonDetailsViewModel(),
          
          
          onViewModelReady: (viewModel)async {
            await viewModel.init(); // Wait for keys to load
        await viewModel.fetchLessonDetails(lessonName);
          },
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final lessonDetails = viewModel.lessonDetails;

        if(!viewModel.hasAccess){
  return Scaffold(
            appBar: AppBar(title: Text(lessonName)),
            body: const Center(
              child: Text(
                'You have no access to this lesson. Please contact the administrator.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.red,fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
        if (lessonDetails == null) {
          return const Scaffold(
            body: Center(
                child: Text(
              'Failed to load lesson details.',
              style: TextStyle(),
            )),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(lessonDetails.title)),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemCount: lessonDetails.contentBlocks.length,
              itemBuilder: (context, index) {
                final block = lessonDetails.contentBlocks[index];
                switch (block.type) {
                  case 'paragraph':
                    return Text(block.text);

                  case 'table':
                    return Table(
                      border: TableBorder.all(),
                      children: block.tableContent.map((row) {
                        return TableRow(
                          children: row
                              .map((cell) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(cell.toString()),
                                  ))
                              .toList(),
                        );
                      }).toList(),
                    );
                    
                  case 'upload':
                    if (block.fileType == 'PDF') {
                      return pdfView(context,
                          'https://peproprep.edusuite.store${block.fileUrl}',"${block.fileUrl}");
                          
                    } else if (block.fileType == 'MP4') {
                      return VideoView(
                          videoUrl:
                              'https://peproprep.edusuite.store${block.fileUrl}');
                    }
                    break;

                    
case 'quiz':
  if (block.data.containsKey('quiz')) {
    final quizzes = block.data['quiz'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Display quiz name(s), whether single or multiple.
        if (quizzes is List)
          ...quizzes.map<Widget>((quiz) => Text(
                quiz.toString(), // Display each quiz name or identifier.
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ))
        else
          Text(
            quizzes.toString(), // Display the single quiz name.
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        const SizedBox(height: 10),
        // Unified "Start Now" button
        ElevatedButton(
          onPressed: () {
            // If there's a single quiz name, pass it directly.
            // If there's a list of quizzes, decide on the first one or show a selection dialog.
            final quizName = quizzes is List
                ? quizzes.isNotEmpty
                    ? quizzes.first.toString() // Choose the first quiz for now.
                    : null
                : quizzes.toString();

            if (quizName != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizPage(quizName: quizName),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No quiz available to start.')),
              );
            }
          },
          child: const Text(
            'Start Now',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  return const SizedBox.shrink();
                  case 'list':
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: block.listItems
                          .map((item) => Text('• $item'))
                          .toList(),
                    );
                  case 'codeBox':
                    return Container(
                      color: Colors.grey[200],
                      padding: const EdgeInsets.all(8.0),
                      child: Text(block.code),
                    );
                  default:
                    return SizedBox.shrink();
                }
                return SizedBox.shrink();
              },
            ),
          ),
        );
      },
    );
  }
}

