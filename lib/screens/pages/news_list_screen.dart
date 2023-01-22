import 'package:cached_network_image/cached_network_image.dart';
import 'package:charity/bloc/home_bloc/home_bloc.dart';
import 'package:charity/bloc/home_bloc/home_event.dart';
import 'package:charity/bloc/home_bloc/home_state.dart';
import 'package:charity/bloc/news_page_bloc/news_page_block.dart';
import 'package:charity/bloc/news_page_bloc/news_page_event.dart';
import 'package:charity/bloc/news_page_bloc/news_page_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/data/repositories/repositories.dart';
import 'package:charity/screens/pages/news_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsListPage extends StatelessWidget {
  NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return newsListScreen(context);
    return BlocProvider(
      create: (context) => NewsBloc()..add(LoadNewsApIEvent()),
      child: newsListScreen(context),
    );
  }

  Scaffold newsListScreen(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: grey,
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state == NewsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is NewsLoadedState) {
              return body(context, state);
            }
            return Container();
          },
        ));
  }

  CustomScrollView body(BuildContext context, NewsLoadedState state) {
    return CustomScrollView(
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
                  bottom:
                      Radius.elliptical(MediaQuery.of(context).size.width, 170),
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: 16, bottom: 80),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return _getCoverNews(index, state, context);
            }, childCount: state.newsModel.length),
          ),
        ),
      ],
    );
  }

  Widget _getCoverNews(int index, NewsLoadedState state, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewsScreen(
                  newsindex: index,
                )));
      },
      child: Padding(
        padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
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
                        state.newsModel[index].newsTitile,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2,
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
                      imageUrl: state.newsModel[index].newsImageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
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
