import 'package:charity/constants/constants.dart';
import 'package:charity/screens/widget/image_slider.dart';
import 'package:charity/screens/widget/news_cover.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: false,
            expandedHeight: AppBar().preferredSize.height + 80,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: blueGradient,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 170),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 48,
                    left: 48,
                    top: 32,
                    bottom: 24,
                  ),
                  child: TextField(
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: blueDark, fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'جست و جو',
                      hintStyle: TextStyle(
                        color: blueDark,
                        fontFamily: 'VL',
                      ),
                      hintTextDirection: TextDirection.rtl,
                      suffixIcon: Icon(
                        Icons.search,
                        color: blueDark,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // SliverPadding(
          //   padding: EdgeInsets.only(top: 16),
          //   sliver: SliverList(
          //     delegate: SliverChildBuilderDelegate((context, index) {
          //       return News();
          //     }, childCount: 10),
          //   ),
          // ),
        ],
      ),
    );
  }
}
