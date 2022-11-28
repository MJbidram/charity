import 'package:charity/constants/constants.dart';

import 'package:charity/screens/widget/hadis_container.dart';
import 'package:charity/screens/widget/image_slider.dart';
import 'package:charity/screens/widget/news_cover.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                  // Status bar color
                  // statusBarColor: Colors.red,
                  ),
              backgroundColor: blueLight,
              pinned: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 16.0),
                  child: Text(
                    shortName,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ],
              leading: Icon(
                Icons.notifications,
                size: 32,
              ),
              expandedHeight: 275,
              flexibleSpace: FlexibleSpaceBar(
                background: ImageSliderScreenTest(),
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
              child: HadisContainer(),
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
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return News();
              }, childCount: 3),
            )
          ],
        ),
      ),
    ));
  }

  Widget _getIcons() {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          height: 54,
          width: 54,
          decoration: BoxDecoration(
            color: blueLight,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.sim_card,
            color: white,
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
