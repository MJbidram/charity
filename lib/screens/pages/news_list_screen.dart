import 'package:charity/constants/constants.dart';
import 'package:charity/screens/pages/news_screen.dart';
import 'package:charity/screens/widget/news_cover.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: grey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(shortName),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            pinned: false,
            expandedHeight: AppBar().preferredSize.height + 30,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: blueGradient,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 170),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 16, bottom: 80),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return News();
              }, childCount: 10),
            ),
          ),
        ],
      ),
    );
  }
}
