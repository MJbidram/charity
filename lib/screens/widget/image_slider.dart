import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:charity/bloc/charity_bloc/charity_event.dart';
import 'package:charity/bloc/charity_bloc/chrity_bloc.dart';
import 'package:charity/bloc/details_of_sliders/details_bloc.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/models/models.dart';
import 'package:charity/screens/pages/charity_screen.dart';
import 'package:charity/screens/pages/main_screen.dart';
import 'package:charity/screens/pages/show_details_of_slider_screen.dart';
import 'package:charity/screens/widget/spin_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSliderScreen extends StatefulWidget {
  static ValueNotifier<bool> goToShortcut = ValueNotifier(false);
  static String? title;
  static int? id;
  ImageSliderScreen({
    super.key,
    required this.myModelList,
  });
  List<dynamic> myModelList;

  @override
  State<ImageSliderScreen> createState() => _ImageSliderScreenState();
}

class _ImageSliderScreenState extends State<ImageSliderScreen> {
  List<dynamic>? pooyeshModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pooyeshModel = widget.myModelList;
  }

  var controler = CarouselController();
  int changePage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: Container(
        height: AppBar().preferredSize.height + 275,
        decoration: BoxDecoration(
          gradient: blueGradient,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(MediaQuery.of(context).size.width, 175),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: AppBar().preferredSize.height,
            ),
            _getImageSlider(),
            SizedBox(
              height: 8,
            ),
            AnimatedSmoothIndicator(
              activeIndex: changePage,
              count: pooyeshModel!.length,
              effect: ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                expansionFactor: 5,
                dotColor: Colors.white,
                activeDotColor: blueLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getImageSlider() {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: pooyeshModel!.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                // image: DecorationImage(
                //     image: NetworkImage(pooyeshModel![index].imagePooyeshHome),
                //     fit: BoxFit.cover),
              ),
              child: GestureDetector(
                onTap: () {
                  MainScreen.isPooyeshSelected = true;
                  // ImageSliderScreen.goToShortcut.value = true;
                  ImageSliderScreen.id = pooyeshModel![index].idPooyeshHome;
                  // ImageSliderScreen.title =
                  //     pooyeshModel![index].titlePooyeshHome;

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => CharityPage(),
                  //     ));
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => DetailSliderBloc(),
                        child: ShowDetailsOfSliderScreen(
                            detailsId: ImageSliderScreen.id!),
                      );
                    },
                  ));
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: pooyeshModel![index].imagePooyeshHome,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                            child: Container(
                                color: blueLight, child: MySpinKit())),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // progressBar(index),
                            _getTitleText(index),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            enableInfiniteScroll: true,
            reverse: true,
            height: 175,
            autoPlay: true,
            pauseAutoPlayInFiniteScroll: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                changePage = index;
              });
            },
          ),
        )
      ],
    );
  }

  Widget _getTitleText(int index) {
    return Stack(
      children: [
        Text(
          pooyeshModel![index].titlePooyeshHome,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = Colors.black, // <-- Border color
          ),
        ),
        Text(
          pooyeshModel![index].titlePooyeshHome,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white, // <-- Inner color
          ),
        ),
      ],
    );
  }

  Widget progressBar(int index) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: LinearPercentIndicator(
        center: Align(
          alignment: Alignment.topCenter,
          child: Text(
            '30%'.toPersianDigit(),
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        width: MediaQuery.of(context).size.width / 1.4,
        lineHeight: 18,
        progressColor: Colors.red,
        backgroundColor: Colors.grey[200],
        percent: 70 / 100,
        barRadius: Radius.circular(8),
        animation: true,
        animationDuration: 2000,
        alignment: MainAxisAlignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8),
        restartAnimation: false,
      ),
    );
  }
}
