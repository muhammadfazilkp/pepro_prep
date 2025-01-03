import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:education_media/service/apiservice.dart';
import 'package:education_media/ui/catogory/catogory_view_model.dart';
import 'package:education_media/ui/chapters/chapter_view.dart';
import 'package:education_media/widgets/diologs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../service/navigation_service.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CatogoryViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.getsecretKey(),
      viewModelBuilder: () =>
          CatogoryViewModel(apiservice: Provider.of<Apiservice>(context)),
      builder: (context, model, child) {
        const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Color.fromARGB(255, 59, 92, 255),
  Color.fromARGB(255, 54, 244, 244),
];

const colorizeTextStyle = TextStyle(
  fontSize: 26.0,
  fontFamily: 'Agne',
  fontWeight: FontWeight.w700
);
        return DefaultTabController(
          length: 6, // Number of tabs
          child: Scaffold(
            appBar: AppBar(
              
              automaticallyImplyLeading: false,
              toolbarHeight: 100,
              title:AnimatedTextKit(
                isRepeatingAnimation: true,
                animatedTexts: [
                 ColorizeAnimatedText(
        "Welcome let's\n get started",
        textStyle: colorizeTextStyle,
        colors: colorizeColors,
        
      ),
      
              ]),
              //  title: const Text('User Name'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => showLogoutDialog(
                        NavigationService.navigationKey.currentContext!,
                        () => model.logOut(context)),
                    child: const Icon(Icons.logout,color: Colors.purple,),
                  ),
                )
              ],
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: 'Live'),
                  Tab(text: 'New'),
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Enrolled'),
                  Tab(text: 'Created'),
                  Tab(text: 'Under Review'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                LiveGridView(), // Live tab content
                Center(child: Text('New content')), // Placeholder for 'New'
                const Center(child: Text('Upcoming content')),
                Center(child: Text('Enrolled content')),
                Center(child: Text('Created content')),
                Center(child: Text('Under Review content'))
              ],
            ),
          ),
        );
      },
    );
  }
}

class LiveGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CatogoryViewModel>.reactive(
      viewModelBuilder: () =>
          CatogoryViewModel(apiservice: Provider.of<Apiservice>(context)),
           onViewModelReady: (viewModel) async {
        await viewModel.getsecretKey(); // Ensure keys are loaded first
        await viewModel.fetchLiveCourses(); // Then fetch the courses
      },
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (viewModel.liveCourses.isEmpty) {
          return const Center(child: Text('No live courses available.'));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: viewModel.liveCourses.length,
          itemBuilder: (context,index) {
            final course = viewModel.liveCourses[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChapterView(courseName: course.name),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.network(
                        'https://peproprep.edusuite.store${course.image}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, size: 48);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        course.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        course.shortIntroduction,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                         course.instructors.isNotEmpty && index < course.instructors.length
        ? course.instructors.first.fullName // Use `first` if all instructors are the same
        : 'No instructor available',
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
