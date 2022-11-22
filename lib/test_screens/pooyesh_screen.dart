import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GetPooyesh extends StatelessWidget {
  const GetPooyesh({super.key});

  @override
  Widget build(BuildContext context) {
    return _getLatestNews();
  }

  Widget _getLatestNews() {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              ' پویش ها',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          CarouselSlider(
            options: CarouselOptions(
              reverse: true,
              height: 220,
              // autoPlay: true,
              // pauseAutoPlayInFiniteScroll: true,
              enlargeCenterPage: true,
            ),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Column(
                    children: [
                      Expanded(
                        child: Container(
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
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'تیتر پویش ها',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
