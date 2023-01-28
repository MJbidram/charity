import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:charity/bloc/home_bloc/home_bloc.dart';
import 'package:charity/bloc/home_bloc/home_event.dart';
import 'package:charity/bloc/home_bloc/home_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/screens/pages/main_screen.dart';
import 'package:charity/screens/pages/news_screen.dart';
import 'package:charity/screens/pages/show_details_of_slider_screen.dart';
import 'package:charity/screens/widget/image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../bloc/details_of_sliders/details_bloc.dart';
import '../../models/charity_model.dart';
import '../widget/spin_kit.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  late double height1;
  @override
  void initState() {
    super.initState();
  }

  int changePage = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadApiEvent()),
      child: homeScreen(),
    );
  }

  Scaffold homeScreen() {
    return Scaffold(
        extendBody: true,
        backgroundColor: grey,
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(
                child: MySpinKit(),
              );
            }
            // State is Loaded data from API =>
            if (state is HomeLoadedState) {
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: blueDark,
                      pinned: true,
                      title: Text(
                        shortName,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      actions: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.notifications,
                            size: 32,
                          ),
                        ),
                      ],
                      expandedHeight: 275,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).viewPadding.top),
                          child: ImageSliderScreen(
                              myModelList: state.pooyeshModel),
                        ),
                      ),
                    ),
                  ];
                },
                body: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 20),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return _getIcons();
                          },
                          childCount: 8,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 18,
                          mainAxisSpacing: 18,
                          mainAxisExtent: 100,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 16, left: 16, top: 16),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: blueGradient,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  state.teller,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  state.arabicText,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  state.farsiText,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              'پروژه ها',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(gradient: blueGradient),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  _getProjectSlider(state),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  AnimatedSmoothIndicator(
                                    activeIndex: changePage,
                                    count: state.projectModel.length,
                                    effect: ExpandingDotsEffect(
                                      dotHeight: 10,
                                      dotWidth: 10,
                                      expansionFactor: 5,
                                      dotColor: Colors.white,
                                      activeDotColor: blueLight,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 16, right: 16, left: 16),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'بیشتر',
                                    style: TextStyle(
                                      fontFamily: 'VB',
                                      fontSize: 16,
                                      // fontWeight: FontWeight.w600,
                                      color: blueDark,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'اخبار',
                                  style: TextStyle(
                                    fontFamily: 'VB',
                                    fontSize: 16,
                                    // fontWeight: FontWeight.w600,
                                    color: blueDark,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(bottom: 80),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return _getNewsCover(index, state);
                        }, childCount: state.newsModl.length),
                      ),
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ));
  }

  Widget _getProjectSlider(HomeLoadedState state) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: state.projectModel.length,
          itemBuilder: (context, index, realIndex) {
            return GestureDetector(
              onTap: () {
                MainScreen.isPooyeshSelected = false;
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => DetailSliderBloc(),
                      child: ShowDetailsOfSliderScreen(
                          detailsId: state.projectModel[index].idProjectHome),
                    );
                  },
                ));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  // image:

                  //  DecorationImage(
                  //     image: NetworkImage(
                  //         state.projectModel[index].imageProjectHome),
                  //     fit: BoxFit.cover),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: state.projectModel[index].imageProjectHome,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: MySpinKit()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
                            progressBar(index, state),
                            _getTitleProjectText(index, state),
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

  progressBar(int index, HomeLoadedState state) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: LinearPercentIndicator(
        center: Align(
          alignment: Alignment.topCenter,
          child: Text(
            '${state.projectModel[index].pishraftProjectHome.toString().toPersianDigit()}' +
                '%',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        width: MediaQuery.of(context).size.width / 1.4,
        lineHeight: 18,
        progressColor: Colors.red,
        backgroundColor: Colors.grey[200],
        percent: state.projectModel[index].pishraftProjectHome / 100,
        barRadius: const Radius.circular(8),
        animation: true,
        animationDuration: 2000,
        alignment: MainAxisAlignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        restartAnimation: false,
      ),
    );
  }

  _getTitleProjectText(int index, HomeLoadedState state) {
    return Stack(
      children: [
        Text(
          state.projectModel[index].titleProjectHome,
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
          state.projectModel[index].titleProjectHome,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white, // <-- Inner color
          ),
        ),
      ],
    );
  }

  Widget _getIcons() {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          height: 54,
          width: 54,
          decoration: BoxDecoration(
            gradient: blueGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.sim_card,
            color: Colors.white,
            size: 34,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'test',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ]),
    );
  }

  Widget _getNewsCover(int index, HomeLoadedState state) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewsScreen(newsindex: index)));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
        child: Container(
          decoration: BoxDecoration(
            color: blueDark,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 175,
                  decoration: BoxDecoration(
                    gradient: blueGradient,
                    // color: blueDark,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.newsModl[index].newsTitile,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4,
                        maxLines: 6,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 175,
                  decoration: BoxDecoration(
                    color: blueDark,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: state.newsModl[index].newsImageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: MySpinKit()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    // Image.network(
                    //   state.newsModl[index].newsImageUrl,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
