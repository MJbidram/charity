import 'package:cached_network_image/cached_network_image.dart';

import 'package:charity/bloc/news_page_bloc/news_page_block.dart';
import 'package:charity/bloc/news_page_bloc/news_page_event.dart';
import 'package:charity/bloc/news_page_bloc/news_page_state.dart';
import 'package:charity/constants/constants.dart';

import 'package:charity/screens/pages/news_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/error_box.dart';
import '../widget/spin_kit.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return newsListScreen(context);
    return BlocProvider(
      create: (context) => NewsBloc()..add(LoadNewsApIEvent()),
      child: newsListScreen(context),
    );
  }

  SafeArea newsListScreen(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          backgroundColor: grey,
          body: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoadingState) {
                return const Center(
                  child: MySpinKit(),
                );
              }
              if (state is NewsLoadedState) {
                return state.response.fold((l) {
                  return const Text('خطا در ارتباط با سرور');
                }, (r) => body(context, r));
              } else {
                return ErrorBox(
                  errorMessage: 'خطا در دریافت اطلاعات',
                  onTap: () {
                    context.read<NewsBloc>().add(LoadNewsApIEvent());
                  },
                );
              }
            },
          )),
    );
  }

  CustomScrollView body(BuildContext context, dynamic r) {
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
          padding: const EdgeInsets.only(top: 16, bottom: 80),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return _getCoverNews(index, r, context);
            }, childCount: r.length),
          ),
        ),
      ],
    );
  }

  Widget _getCoverNews(int index, dynamic r, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewsScreen(
                  newsindex: r[index].newsId,
                )));
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
                        r[index].newsTitile,
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
                      imageUrl: r[index].newsImageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                          child: Container(
                              color: blueLight, child: const MySpinKit())),
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
