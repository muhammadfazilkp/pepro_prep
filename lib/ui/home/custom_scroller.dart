import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomScroller extends StatelessWidget {
  const CustomScroller({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Container(
          child:   Center(child: Text('Item 1')),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(15)),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(15)),
          child: const Center(child: Text('Item 2')),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(15)),
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
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: (index, reason) {
          reason;
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
