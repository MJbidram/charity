import 'package:carousel_slider/carousel_slider.dart';
import 'package:charity/constants/constants.dart';
import 'package:flutter/material.dart';

class ImageSliderScreenTest extends StatefulWidget {
  const ImageSliderScreenTest({super.key});

  @override
  State<ImageSliderScreenTest> createState() => _ImageSliderScreenTestState();
}

class _ImageSliderScreenTestState extends State<ImageSliderScreenTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: AppBar().preferredSize.height + 350,
        decoration: BoxDecoration(
          gradient: blueGradient,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(MediaQuery.of(context).size.width, 170),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: AppBar().preferredSize.height,
            ),
            _getImageSlider(),
          ],
        ),
      ),
    );
  }

  CarouselSlider _getImageSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        reverse: true,
        height: 175,
        autoPlay: true,
        pauseAutoPlayInFiniteScroll: true,
        enlargeCenterPage: true,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: AssetImage(
                      'images/item${i + 10}.png',
                    ),
                    fit: BoxFit.cover),
              ),
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _getTitleText(),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _getTitleText() {
    return Stack(
      children: [
        Text(
          'Outlined Text',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = Colors.black, // <-- Border color
          ),
        ),
        const Text(
          'Outlined Text',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white, // <-- Inner color
          ),
        ),
      ],
    );
  }
}
