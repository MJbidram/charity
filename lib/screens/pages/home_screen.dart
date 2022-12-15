import 'package:carousel_slider/carousel_slider.dart';
import 'package:charity/bloc/home_bloc/home_bloc.dart';
import 'package:charity/bloc/home_bloc/home_event.dart';
import 'package:charity/bloc/home_bloc/home_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/repositories/repositories.dart';

import 'package:charity/screens/widget/image_slider.dart';
import 'package:charity/screens/widget/news_cover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  late double height1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int changePage = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(RepositoryProvider.of<Repositories>(context))
            ..add(LoadApiEvent()),
      child: scaffoldHomeScreen(),
    );
  }

  Scaffold scaffoldHomeScreen() {
    return Scaffold(
        extendBody: true,
        backgroundColor: grey,
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
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
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                      padding: EdgeInsets.only(top: 20),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return _getIcons();
                          },
                          childCount: 8,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  state.arabicText,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                SizedBox(
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
                          SizedBox(
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
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(gradient: blueGradient),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  _getProjectSlider(state),
                                  SizedBox(
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
                                  SizedBox(
                                    height: 12,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 16, right: 16, left: 16),
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
                                Spacer(),
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
                      padding: EdgeInsets.only(bottom: 80),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return News();
                        }, childCount: 3),
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
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: NetworkImage(
                        state.projectModel[index].imageProjectHome),
                    fit: BoxFit.cover),
              ),
              child: Align(
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
      margin: EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: LinearPercentIndicator(
        center: Align(
          alignment: Alignment.topCenter,
          child: Text(
            '${state.projectModel[index].pishraftProjectHome}' + '%',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        width: MediaQuery.of(context).size.width / 1.4,
        lineHeight: 18,
        progressColor: Colors.red,
        backgroundColor: Colors.grey[200],
        percent: state.projectModel[index].pishraftProjectHome / 100,
        barRadius: Radius.circular(8),
        animation: true,
        animationDuration: 2000,
        alignment: MainAxisAlignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8),
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
          style: TextStyle(
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
          child: Icon(
            Icons.sim_card,
            color: Colors.white,
            size: 34,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'test',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ]),
    );
  }
}
