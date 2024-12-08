import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:education_media/app/images.dart';
import 'package:education_media/ui/lessons/lesson_details_page.dart';
import 'package:education_media/ui/lessons/lessons_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LessonGridView extends StatelessWidget {
  final String? chapterName;

  LessonGridView({ this.chapterName});

  @override
   Widget build(BuildContext context) {
    return ViewModelBuilder<LessonViewModel>.reactive(
      viewModelBuilder: () => LessonViewModel()..fetchLessons(chapterName!),
      builder: (context, viewModel, child) {
        if (viewModel.isLoadingLessons) {
          return const Center(child: CircularProgressIndicator());
        }
        if (viewModel.chapterWithLessons == null ||
            viewModel.chapterWithLessons!.lessons.isEmpty) {
          return const Center(child: Text('No lessons available.'));
        }
        final lessons = viewModel.chapterWithLessons!.lessons;
        return Scaffold(
          appBar: AppBar(
            title: Text('Lessons in ${viewModel.chapterWithLessons!.title}'),
          ),
          body: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              return InkWell(
                onTap: (){
                   Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LessonDetailsPage(lessonName: lesson.lesson),
    ),
  );
                },
                child: Card(
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                                                            height: 50, 
                                                            width: 50,
                                                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: AssetImage(lessonImage), // Replace with your asset
                                fit: BoxFit.fill,
                              ),
                                                            ),
                                                          ),
                      Center(
                        child: AnimatedTextKit(animatedTexts: [
                          TypewriterAnimatedText(lesson.lesson,textStyle: TextStyle(fontFamily: 'Agne',fontSize: 16,fontWeight: FontWeight.w600))
                        ])
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
