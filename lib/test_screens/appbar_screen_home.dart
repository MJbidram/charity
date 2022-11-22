import 'package:charity/constants/constants.dart';
import 'package:charity/test_screens/features_screen-test.dart';
import 'package:charity/test_screens/pooyesh_screen.dart';
import 'package:charity/test_screens/hadis_screen_test.dart';
import 'package:charity/test_screens/image_slider_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppbarScreen extends StatefulWidget {
  const AppbarScreen({super.key});

  @override
  State<AppbarScreen> createState() => _AppbarScreenState();
}

class _AppbarScreenState extends State<AppbarScreen> {
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
                statusBarColor: Colors.red,
              ),
              backgroundColor: blueLight,
              pinned: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.menu,
                    size: 32,
                  ),
                ),
              ],
              leading: Icon(
                Icons.person,
                size: 32,
              ),
              centerTitle: true,
              title: Container(
                height: 32,
                width: 32,
                child: ClipRRect(
                  child: Image.asset(
                    'images/logo.png',
                  ),
                ),
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
                    return _getIcons2();
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
              child: GetPooyesh(),
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
                            '<<  بیشتر',
                          ),
                        ),
                        Spacer(),
                        Text('اخبار'),
                      ],
                    )),
              ),
            ),
            SliverToBoxAdapter(
              child: _getNewsList(),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _getIcons2() {
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

  Widget _getNewsList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _getCoevrNews(context);
      },
    );
  }

  Widget _getCoevrNews(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          height: 200,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Stack(children: [
            Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: blueLight,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Container(
                margin: EdgeInsets.only(right: 20, bottom: 12),
                height: 188,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  color: blueDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('تصویر'),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Container(
                color: Colors.transparent,
                height: 150,
                width: MediaQuery.of(context).size.width -
                    (MediaQuery.of(context).size.width / 3) -
                    20,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('تیتر خبر'),
                        Text(
                          'خلاصه خبر',
                          style: TextStyle(fontSize: 18),
                        ),
                      ]),
                ),
              ),
            )
          ]),
        ),
      ],
    );
  }
}
