import 'package:education_media/constants/app_constants.dart';
import 'package:education_media/ui/home/custom_scroller.dart';
import 'package:education_media/ui/login/login_response_model.dart';
import 'package:education_media/ui/video/video_view.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
 final LoginResponse? loginResponse;
   HomeView({super.key,  this.loginResponse});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewmodel>.reactive(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  padding: const  EdgeInsets.only(right: 190),
                  child:   Text(
                    'hello ${loginResponse!.fullName}',
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                const CustomScroller(),
                const SizedBox(height: 20),
                Text(
                  'Current Page: ${viewModel.currentPage}',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Physics',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      InkWell(
                        onTap: () {
                          // navigationService.pushNamed(RoutePaths.videoView);/
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoView(),
                              ));
                        },
                        child: Text(
                          'View all ',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 170,
                        height: 90,
                        // color: Colors.amber,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return GestureDetector(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(8.0),
                                          height: 130,
                                          width: constraints.maxWidth,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/poster.jpg'),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    " Lorem Ipsum is simply dummy text of the printing and typesetting ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "5:49",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 7,
                    ),
                    itemCount: 10,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 180,
                        child: Container(
                          width: 170,
                          // color: Colors.amber,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return GestureDetector(
                                onTap: () {},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(8.0),
                                            height: 130,
                                            width: constraints.maxWidth,
                                            decoration: BoxDecoration(
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/poster.jpg'),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Text(
                                      " Lorem Ipsum is simply dummy text of the printing and typesetting ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "5:49",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(.7),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 7,
                    ),
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewmodel(),
    );
  }
}
