import 'package:charity/constants/constants.dart';
import 'package:charity/screens/widget/botom_sheet_comments.dart';
import 'package:flutter/material.dart';

class MyNewsPage extends StatelessWidget {
  const MyNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,

      // appBar: _const_appbar(context),

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: AppBar(
          elevation: 0,
          toolbarHeight: 60,
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
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Container(
              decoration: BoxDecoration(
                gradient: blueGradient,
                borderRadius: BorderRadius.vertical(
                  bottom:
                      Radius.elliptical(MediaQuery.of(context).size.width, 170),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: blueGradient,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 170),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 170),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 170),
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/item15.jpg',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 16,
            ),
            sliver: SliverToBoxAdapter(
              child: Container(
                color: white,
                child: Row(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.timer_outlined),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'زمان انتشار',
                      style: TextStyle(fontFamily: 'Vl', fontSize: 14),
                    ),
                    Spacer(),
                    Icon(Icons.question_answer_outlined),
                    Text(
                      '0',
                      style: TextStyle(
                          fontSize: 12, fontFamily: 'VL', color: black),
                    ),
                    Text(
                      'دیدگاه',
                      style: TextStyle(
                          fontSize: 12, fontFamily: 'VL', color: black),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Icon(Icons.favorite_outline),
                    SizedBox(
                      width: 16,
                    ),
                    Icon(Icons.bookmark_add_outlined)
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: 16,
            ),
            sliver: SliverToBoxAdapter(
              child: Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  'موضوع خبر',
                  style: Theme.of(context).textTheme.headline5,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 32, right: 16, left: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                newsTest,
                style: Theme.of(context).textTheme.headline6,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
            sliver: SliverToBoxAdapter(
                child: Container(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blueDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  _getBottomSheetNavigation(context);
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'مشاهده و افزودن دیدگاه',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.question_answer_outlined,
                    size: 24,
                  ),
                ]),
              ),
            )),
          ),
        ],
      ),
    );
  }

  PreferredSize _const_appbar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(250),
      child: AppBar(
        elevation: 0,
        toolbarHeight: 60,
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
        backgroundColor: Colors.white,
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: Container(
            decoration: BoxDecoration(
              gradient: blueGradient,
              borderRadius: BorderRadius.vertical(
                bottom:
                    Radius.elliptical(MediaQuery.of(context).size.width, 170),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: blueGradient,
                borderRadius: BorderRadius.vertical(
                  bottom:
                      Radius.elliptical(MediaQuery.of(context).size.width, 170),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom:
                      Radius.elliptical(MediaQuery.of(context).size.width, 170),
                ),
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/item15.jpg',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _getBottomSheetNavigation(BuildContext context) {
    return showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.3,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return BottomSheetComments(
                controller: scrollController,
              );
            },
          ),
        );
      },
    );
  }
}
