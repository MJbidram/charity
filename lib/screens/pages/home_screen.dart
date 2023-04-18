import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:charity/bloc/home_bloc/home_bloc.dart';
import 'package:charity/bloc/home_bloc/home_event.dart';
import 'package:charity/bloc/home_bloc/home_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/models/home_models.dart';
import 'package:charity/screens/pages/main_screen.dart';
import 'package:charity/screens/pages/news_screen.dart';
import 'package:charity/screens/pages/show_details_of_slider_screen.dart';
import 'package:charity/screens/widget/image_slider.dart';
import 'package:charity/util/home_items_metods.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../bloc/details_of_sliders/details_bloc.dart';

import '../widget/error_box.dart';
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
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const Center(
                  child: MySpinKit(),
                );
              }
              // State is Loaded data from API =>
              if (state is HomeLoadedState) {
                return state.response.fold((l) {
                  return const Center(
                    child: Text('خطا در ارتباط با سرور'),
                  );
                }, (r) {
                  return NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          backgroundColor: Colors.transparent,
                          pinned: true,
                          title: Text(
                            shortName,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                onPressed: () {
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.scale,
                                    dialogType: DialogType.warning,
                                    body: const Center(
                                      child: Text(
                                        'به زودی ...',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                    title: 'This is Ignored',
                                    desc: 'This is also Ignored',
                                    btnOkOnPress: () {},
                                  ).show();
                                },
                                icon: const Icon(
                                  Icons.notifications,
                                  size: 32,
                                ),
                              ),
                            ),
                          ],
                          expandedHeight: 275,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).viewPadding.top),
                              child: r[0].length == 0
                                  ? Container(
                                      height:
                                          AppBar().preferredSize.height + 275,
                                      decoration: BoxDecoration(
                                        gradient: blueGradient,
                                        borderRadius: BorderRadius.vertical(
                                          bottom: Radius.elliptical(
                                              MediaQuery.of(context).size.width,
                                              175),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                AppBar().preferredSize.height,
                                          ),
                                          _getProjectSlider(r),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    )
                                  : ImageSliderScreen(myModelList: r[0]),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 16, left: 16),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return _getIcons(r[3][index]);
                              },
                              childCount: r[3].length,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 18,
                              mainAxisExtent: 150,
                            ),
                          ),
                        ),
                        r[4].length != 0
                            ? SliverPadding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                sliver: SliverToBoxAdapter(
                                  child: Visibility(
                                      visible: true, child: _getImageSlider(r)),
                                ),
                              )
                            : const SliverToBoxAdapter(),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, top: 16),
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
                                      r[2].teller,
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      r[2].arabicText,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      r[2].farsiText,
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        r[0].length != 0
                            ? SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: Text(
                                        'پروژه ها',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
                                    // پروژه ها
                                    Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        decoration: BoxDecoration(
                                            gradient: blueGradient),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            _getProjectSlider(r),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            AnimatedSmoothIndicator(
                                              activeIndex: changePage,
                                              count: r[1].length,
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
                              )
                            : const SliverToBoxAdapter(
                                child: SizedBox(height: 4),
                              ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16, right: 16, left: 16, bottom: 8),
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              return _getNewsCover(index, state);
                            }, childCount: state.newsModl.length),
                          ),
                        )
                      ],
                    ),
                  );
                });
              } else {
                return ErrorBox(
                  errorMessage: 'خطا در دریافت اطلاعات',
                  onTap: () {
                    context.read<HomeBloc>().add(LoadApiEvent());
                  },
                );
              }
            },
          ),
        ));
  }

  Widget _getImageSlider(List r) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: r[4].length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 8),
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
                      imageUrl: r[4][index].url,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: MySpinKit()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            autoPlayInterval: const Duration(seconds: 6),
            enableInfiniteScroll: true,
            reverse: true,
            height: 200,
            autoPlay: true,
            pauseAutoPlayInFiniteScroll: false,
            enlargeCenterPage: false,
            viewportFraction: 1,
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

  Widget _getProjectSlider(List r) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: r[1].length,
          itemBuilder: (context, index, realIndex) {
            return GestureDetector(
              onTap: () {
                MainScreen.isPooyeshSelected = false;
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => DetailSliderBloc(),
                      child: ShowDetailsOfSliderScreen(
                          detailsId: r[1][index].idProjectHome),
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
                        imageUrl: r[1][index].imageProjectHome,
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
                            progressBar(index, r),
                            _getTitleProjectText(index, r),
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

  progressBar(int index, List r) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: LinearPercentIndicator(
        center: Align(
          alignment: Alignment.topCenter,
          child: Text(
            '${r[1][index].pishraftProjectHome.toString().toPersianDigit()}'
            '%',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        width: MediaQuery.of(context).size.width / 1.4,
        lineHeight: 18,
        progressColor: Colors.red,
        backgroundColor: Colors.grey[200],
        percent: r[1][index].pishraftProjectHome / 100,
        barRadius: const Radius.circular(8),
        animation: true,
        animationDuration: 2000,
        alignment: MainAxisAlignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        restartAnimation: false,
      ),
    );
  }

  _getTitleProjectText(int index, List r) {
    return Stack(
      children: [
        Text(
          '${r[1][index].titleProjectHome}',
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
          r[1][index].titleProjectHome,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white, // <-- Inner color
          ),
        ),
      ],
    );
  }

  Widget _getIcons(HomeItemsModel itemsModel) {
    return Center(
      child: GestureDetector(
        onTap: () {
          ManageHomeItems itemManager =
              ManageHomeItems(itemsModel.action.cast(), context);
          itemManager.decoder();
        },
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  gradient: blueGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: CachedNetworkImage(
                    imageUrl: itemsModel.icon,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: MySpinKit()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 40,
                child: Text(
                  itemsModel.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  Widget _getNewsCover(int index, HomeLoadedState state) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                NewsScreen(newsindex: state.newsModl[index].newsId)));
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
