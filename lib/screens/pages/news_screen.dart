import 'package:cached_network_image/cached_network_image.dart';
import 'package:charity/bloc/home_bloc/home_event.dart';
import 'package:charity/bloc/news_page_bloc/news_page_block.dart';
import 'package:charity/bloc/news_page_bloc/news_page_event.dart';
import 'package:charity/bloc/news_page_bloc/news_page_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/screens/widget/botom_sheet_comments.dart';
import 'package:charity/screens/widget/error_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../widget/spin_kit.dart';

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
            return const Scaffold(
              body: Center(
                child: MySpinKit(),
              ),
            );
          }
          if (state is NewsLoadedState) {
            return state.response.fold((l) {
              return ErrorBox(
                errorMessage: 'خطا در دریافت اطلاعات از سرور',
                onTap: () {
                  context.read<NewsBloc>().add(LoadNewsApIEvent());
                },
              );
            }, (r) {
              return _getBody(context, r);
            });
          } else {
            return ErrorBox(
              errorMessage: 'خطا در دریافت اطلاعات از سرور',
              onTap: () {
                context.read<NewsBloc>().add(LoadNewsApIEvent());
              },
            );
          }
        },
      ),
    );
  }

  Scaffold _getBody(BuildContext context, dynamic state) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              toolbarHeight: 70,
              expandedHeight: 250,
              collapsedHeight: 100,
              actions: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 170),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: state[newsindex].newsImageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.only(
                bottom: 8,
                top: 16,
              ),
              sliver: SliverToBoxAdapter(
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      // 'dafaf',
                      state[newsindex].newsTitile,
                      style: Theme.of(context).textTheme.headline5,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 16,
              ),
              sliver: SliverToBoxAdapter(
                child: Container(
                  color: white,
                  child: Row(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.timer_outlined),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        // '111',
                        state[newsindex]
                            .newsDate
                            .toString()
                            .substring(0, 10)
                            .toPersianDate(),

                        style: const TextStyle(fontFamily: 'Vl', fontSize: 14),
                      ),
                      // const Spacer(),
                      // const Icon(Icons.question_answer_outlined),
                      // Text(
                      //   '0',
                      //   style: TextStyle(
                      //       fontSize: 12, fontFamily: 'VL', color: black),
                      // ),
                      // Text(
                      //   'دیدگاه',
                      //   style: TextStyle(
                      //       fontSize: 12, fontFamily: 'VL', color: black),
                      // ),
                      // const SizedBox(
                      //   width: 16,
                      // ),
                      // const Icon(Icons.favorite_outline),
                      // const SizedBox(
                      //   width: 16,
                      // ),
                      // const Icon(Icons.bookmark_add_outlined)
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 32, right: 12, left: 12),
              sliver: SliverToBoxAdapter(
                  child: Html(
                data: state[newsindex].newsText,
              )),
            ),
            // SliverPadding(
            //   padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
            //   sliver: SliverToBoxAdapter(
            //       child: Container(
            //     height: 50,
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: blueDark,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(16),
            //         ),
            //       ),
            //       onPressed: () {
            //         _getBottomSheetNavigation(context);
            //       },
            //       child:
            //           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //         Text(
            //           'مشاهده و افزودن دیدگاه',
            //           style: Theme.of(context).textTheme.headline4,
            //         ),
            //         const SizedBox(
            //           width: 4,
            //         ),
            //         const Icon(
            //           Icons.question_answer_outlined,
            //           size: 24,
            //         ),
            //       ]),
            //     ),
            //   )),
            // ),
          ],
        ),
      ),
    );
  }

  PreferredSize _const_appbar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(250),
      child: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        title: Text(
          shortName,
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
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
                child: const Image(
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
