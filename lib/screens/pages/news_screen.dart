import 'package:cached_network_image/cached_network_image.dart';
import 'package:charity/bloc/home_bloc/home_event.dart';
import 'package:charity/bloc/home_bloc/home_state.dart';
import 'package:charity/bloc/news_page_bloc/news_page_block.dart';
import 'package:charity/bloc/news_page_bloc/news_page_event.dart';
import 'package:charity/bloc/news_page_bloc/news_page_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/repositories/repositories.dart';
import 'package:charity/screens/widget/botom_sheet_comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:percent_indicator/percent_indicator.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({super.key, required this.newsindex});
  int newsindex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc()..add(LoadNewsApIEvent()),
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadingState) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is NewsLoadedState) {
            return _getBody(context, state);
          }
          return Container();
        },
      ),
    );

    // Scaffold(
    //   body: BlocBuilder<NewsBloc, NewsState>(
    //     builder: (context, state) {
    //       if (state is NewsLoadingState) {
    //         return Container(
    //           color: Colors.amber,
    //         );
    //       } else {
    //         return Container(
    //           color: Colors.red,
    //         );
    //       }
    //     },
    //   ),
    // );

    // BlocProvider(
    //   create: (context) =>
    //       NewsPageBloc(RepositoryProvider.of<Repositories>(context))
    //         ..add(LoadNewsApIEvent()),
    //   child: BlocBuilder<NewsPageBloc, NewsPageState>(
    //     builder: (context, state) {
    //       if (state is HomeLoadingState) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       if (state is NewsPageLoadedState) {
    //         return _getBody(context, state);
    //       }
    //       return Container();
    //     },
    //   ),
    // );
  }

  Scaffold _getBody(BuildContext context, NewsLoadedState state) {
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
                    child: CachedNetworkImage(
                      imageUrl: state.newsModel[newsindex].newsImageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
                      // '111',
                      state.newsModel[newsindex].newsDate,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    // 'dafaf',
                    state.newsModel[newsindex].newsTitile,
                    style: Theme.of(context).textTheme.headline5,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 32, right: 12, left: 12),
            sliver: SliverToBoxAdapter(
                child: Html(
              data: state.newsModel[newsindex].newsText,
            )
                // Text(
                //   // 'fdafdadaf',
                //   state.newsModel[newsindex].newsText,
                //   style: Theme.of(context).textTheme.headline6,
                //   textDirection: TextDirection.rtl,
                //   textAlign: TextAlign.justify,
                // ),
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
