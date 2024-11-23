
import 'package:education_media/ui/video/video_view.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart'; 

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'hello Student Name',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                CarouselSlider(
                  items: [
                    Container(
                      child: const Center(child: Text('Item 1')),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(child: Text('Item 2')),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(child: Text('Item 3')),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 150,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    onPageChanged: (index, reason) {
                      viewModel.onPageChanged(index);
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoView(),));
                          
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
