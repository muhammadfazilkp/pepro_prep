import 'package:education_media/constants/app_constants.dart';
import 'package:education_media/service/apiservice.dart';
import 'package:education_media/service/navigation_service.dart';
import 'package:education_media/ui/home/custom_scroller.dart';
import 'package:education_media/ui/login/login_response_model.dart';
import 'package:education_media/ui/login/login_view_model.dart';
import 'package:education_media/ui/video/video_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewmodel>.reactive(
      onViewModelReady: (model) => model.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(right: 190),
                  child: Text(
                    'Hello', // You can modify this as needed
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                const CustomScroller(),
                const SizedBox(height: 20),
                Text(
                  'Current Page:',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          viewModel.loGoutUser();
                        },
                        child: Text(
                          'Physics',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoView(),
                            ),
                          );
                        },
                        child: Text(
                          'View all',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                // Use the data fetched from HomeViewModel
                Expanded(
                    child: viewModel.coureses == null
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return Container(
                                height: 40,
                                width: 90,
                                color: Colors.amber,
                                child: Column(
                                  children: [
                                    // Text(viewModel.coureses!.data!.body!),
                                    Text(viewModel.coureses!.data!.name!),
                                  ],
                                ),
                              );
                            },
                          )),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewmodel(
        Apiservice: Provider.of<Apiservice>(context),
        LoginViewModel: Provider.of<LoginViewModel>(context),
      ),
    );
  }
}
