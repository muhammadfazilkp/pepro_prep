import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:education_media/app/images.dart';
import 'package:education_media/ui/chapters/chapter_veiwmodel.dart';
import 'package:education_media/ui/lessons/lessons_list_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChapterView extends StatelessWidget {
  final String? courseName;

  const ChapterView({Key? key, this.courseName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ViewModelBuilder<ChapterVeiwmodel>.reactive(
      onViewModelReady: (viewModel)async {

         await viewModel.init(); // Wait for keys to load
        await viewModel.fetchChapters(courseName!);
      },
      viewModelBuilder: ()=>ChapterVeiwmodel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Chapters for $courseName'),
          ),
          body: viewModel.isLoadingchapters
              ? const Center(child: CircularProgressIndicator())
              : viewModel.chapters.isEmpty
                  ? const Center(child: Text('No chapters available.'))
                  : ListView.separated(
                    
                      padding: const EdgeInsets.all(8.0),
                      itemCount: viewModel.chapters.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final chapter = viewModel.chapters[index];
                                String chaptername=chapter.name;
                                 String trimmedText = chaptername.split(' ').skip(1).join(' ');

                        return GestureDetector(
                          onTap: (){
                         viewModel.isLoadingchapters
                         ?Center(child: CircularProgressIndicator(),)
                            : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LessonGridView(chapterName: chapter.name),
                              ),
                            );
                          },
                          child: Card(
                            
                            child: ListTile(
                            trailing: InkWell(child: Icon(Icons.keyboard_double_arrow_right_rounded),onTap: (){
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LessonGridView(chapterName: chapter.name),
                              ),
                            );
                            },),
                              title:AnimatedTextKit(
                                
                                animatedTexts: [
                                TyperAnimatedText(trimmedText,textStyle: TextStyle(fontFamily: 'Agne',fontSize: 16,fontWeight: FontWeight.w600))
                              ]),
                              leading:Container(
                                                            height: 50, 
                                                            width: 50,
                                                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(chapterImage), // Replace with your asset
                                fit: BoxFit.cover,
                              ),
                                                            ),
                                                          ) ,
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
