import 'package:charity/bloc/home_bloc/home_bloc.dart';
import 'package:charity/bloc/home_bloc/home_event.dart';
import 'package:charity/bloc/home_bloc/home_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/repositories/repositories.dart';
import 'package:charity/screens/pages/news_screen.dart';

import 'package:charity/screens/widget/hadis_container.dart';
import 'package:charity/screens/widget/image_slider.dart';
import 'package:charity/screens/widget/news_cover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
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
                      backgroundColor: blueLight,
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
                          padding: const EdgeInsets.only(top: 48),
                          child: ImageSliderScreenTest(),
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
                          height: 175,
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
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  state.arabicText,
                                  style: Theme.of(context).textTheme.headline2,
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
