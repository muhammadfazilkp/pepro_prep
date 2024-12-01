import 'package:education_media/ui/catogory/catogory_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';



class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CatogoryViewModel>.reactive(
      viewModelBuilder: () => CatogoryViewModel(),
      builder: (context, viewModel, child) {
        return DefaultTabController(
          length: 6, // Number of tabs
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Categories'),
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
      viewModelBuilder: () => CatogoryViewModel()..fetchLiveCourses(),
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
          itemBuilder: (context, index) {
            final course = viewModel.liveCourses[index];
            return Card(
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
                      course.instructors[index].fullName,
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}