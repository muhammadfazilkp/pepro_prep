import 'package:education_media/ui/chapters/chapter_veiwmodel.dart';
import 'package:education_media/ui/lessons/lessons_list_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChapterView extends StatelessWidget {
  final String? courseName;

  const ChapterView({Key? key,  this.courseName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChapterVeiwmodel>.reactive(
      viewModelBuilder: () => ChapterVeiwmodel()..fetchChapters(courseName!),
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
                        return InkWell(
                          onTap: (){
                             Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LessonGridView(chapterName: chapter.name),
                  ),
                );
                          },
                          child: Card(
                            elevation: 4,
                            child: ListTile(
                              
                              title: Text(
                                chapter.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
