import 'package:charity/constants/constants.dart';
import 'package:flutter/material.dart';

class MyNewsPage extends StatelessWidget {
  const MyNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var mystring = MyStrings();
    var t = mystring.newsTest;
    return Scaffold(
        backgroundColor: whiet,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(250),
          child: AppBar(
            elevation: 0,
            toolbarHeight: 60,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 16.0),
                child: Text(
                  'خیریه امام علی (ع) شهر گرگاب',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ],
            leading: Icon(
              Icons.notifications,
              size: 32,
            ),
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: blueGradient,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 170),
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
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/item15.png',
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
                  color: whiet,
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
                  t,
                  style: Theme.of(context).textTheme.headline6,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ));
  }
}
