import 'package:cached_network_image/cached_network_image.dart';
import 'package:charity/bloc/details_of_sliders/details_bloc.dart';
import 'package:charity/bloc/details_of_sliders/details_event.dart';
import 'package:charity/bloc/details_of_sliders/details_state.dart';
import 'package:charity/bloc/news_page_bloc/news_page_block.dart';
import 'package:charity/bloc/news_page_bloc/news_page_event.dart';
import 'package:charity/bloc/news_page_bloc/news_page_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/screens/pages/main_screen.dart';
import 'package:charity/screens/widget/botom_sheet_comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../widget/image_slider.dart';
import '../widget/spin_kit.dart';
import 'charity_screen.dart';

class ShowDetailsOfSliderScreen extends StatefulWidget {
  ShowDetailsOfSliderScreen({super.key, required this.detailsId});
  int detailsId;

  @override
  State<ShowDetailsOfSliderScreen> createState() =>
      _ShowDetailsOfSliderScreenState();
}

class _ShowDetailsOfSliderScreenState extends State<ShowDetailsOfSliderScreen> {
  @override
  void initState() {
    if (MainScreen.isPooyeshSelected) {
      BlocProvider.of<DetailSliderBloc>(context)
          .add(LoadPooyshEvent(widget.detailsId));
    } else {
      BlocProvider.of<DetailSliderBloc>(context)
          .add(LoadProjectEvent(widget.detailsId));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailSliderBloc, DetailState>(
        builder: (context, state) {
          if (state is DetailLoadingState) {
            return const Center(
              child: MySpinKit(),
            );
          }
          if (state is DetailShowPooyeshState) {
            return state.response.fold((l) {
              print(l);
              return const Center(
                child: Text('خطا در دریافت اطلاعات'),
              );
            }, (r) {
              return Body(
                amunt: r.amount.toString(),
                id: r.typePay,
                title: r.title,
                date: 'k',
                description: r.description,
                imageUrl: r.imageUrl,
              );
            });
          }
          if (state is DetailShowProjectsState) {
            return state.response.fold((l) {
              print(l);
              return const Center(
                child: Text('خطا در دریافت اطلاعات'),
              );
            }, (r) {
              return Body(
                id: r.typePay,
                title: r.title,
                date: 'k',
                description: r.description,
                imageUrl: r.imageUrl,
                index: r.pishraft,
              );
            });
          } else {
            return const Center(
              child: Text('خطا در دریافت'),
            );
          }
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  int? id;
  String imageUrl;
  String date;
  String description;
  String title;
  int? index;
  String? amunt;
  Body({
    required this.title,
    required this.date,
    required this.description,
    required this.imageUrl,
    this.id,
    this.index,
    this.amunt,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,

      // appBar: _const_appbar(context),

      appBar: PreferredSize(
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
                    // child: Image.asset('assets/images/item10.jpg'),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: MySpinKit()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
          const SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            // sliver: SliverToBoxAdapter(
            //   child: Container(
            //     color: white,
            //     child:
            //  Row(
            //   textDirection: TextDirection.rtl,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children:const [
            //      Icon(Icons.timer_outlined),
            //      SizedBox(
            //       width: 4,
            //     ),
            // Text(
            //   date,
            //   style: const TextStyle(fontFamily: 'Vl', fontSize: 14),
            // ),
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
            //   ],
            // ),
            //   ),
            // ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              bottom: 8,
            ),
            sliver: SliverToBoxAdapter(
              child: Align(
                alignment: AlignmentDirectional.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    title,
                    // state.newsModel[newsindex].newsTitile,
                    style: Theme.of(context).textTheme.headline5,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          ),
          MainScreen.isPooyeshSelected == true
              ? SliverPadding(
                  padding: EdgeInsets.only(bottom: 8, right: 16, left: 16),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(' هزینه مورد نیاز'),
                        Spacer(),
                        Text('${amunt?.toWord()} تومان'),
                        Spacer(),
                        Text('${amunt?.toPersianDigit().seRagham()}'),
                      ],
                    ),
                  ),
                )
              : SliverToBoxAdapter(),
          MainScreen.isPooyeshSelected == false
              ? SliverPadding(
                  padding: EdgeInsets.only(bottom: 8, right: 16, left: 16),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(' پیشرفت'),
                        Spacer(),
                        progressBar(index ?? 0, context),
                      ],
                    ),
                  ),
                )
              : SliverToBoxAdapter(),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 32, right: 12, left: 12),
            sliver: SliverToBoxAdapter(
              child: Text(description),
              //   Html(
              // data: state.newsModel[newsindex].newsText,
            ),
          ),
          MainScreen.isPooyeshSelected
              ? SliverPadding(
                  padding:
                      const EdgeInsets.only(bottom: 16, right: 16, left: 16),
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
                        ImageSliderScreen.goToShortcut.value = true;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CharityPage(id: id!, title: title),
                            ));
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'مشارکت در پویش',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            // const SizedBox(
                            //   width: 4,
                            // ),
                            // const Icon(
                            //   Icons.question_answer_outlined,
                            //   size: 24,
                            // ),
                          ]),
                    ),
                  )),
                )
              : id == null
                  ? SliverToBoxAdapter()
                  : SliverPadding(
                      padding: const EdgeInsets.only(
                          bottom: 16, right: 16, left: 16),
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
                            ImageSliderScreen.goToShortcut.value = true;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CharityPage(id: id!, title: title),
                                ));
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'مشارکت در پروژه',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                // const SizedBox(
                                //   width: 4,
                                // ),
                                // const Icon(
                                //   Icons.question_answer_outlined,
                                //   size: 24,
                                // ),
                              ]),
                        ),
                      ))),
        ],
      ),
    );
  }

  Widget progressBar(int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: LinearPercentIndicator(
        center: Align(
          alignment: Alignment.topCenter,
          child: Text(
            index.toString().toPersianDigit() + '%',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        width: MediaQuery.of(context).size.width / 1.4,
        lineHeight: 18,
        progressColor: Colors.red,
        backgroundColor: Colors.grey[200],
        percent: index / 100,
        barRadius: Radius.circular(8),
        animation: true,
        animationDuration: 2000,
        alignment: MainAxisAlignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8),
        restartAnimation: false,
      ),
    );
  }
}


// PreferredSize _const_appbar(BuildContext context) {
//     return PreferredSize(
//       preferredSize: const Size.fromHeight(250),
//       child: AppBar(
//         elevation: 0,
//         toolbarHeight: 60,
//         title: Text(
//           shortName,
//           style: Theme.of(context).textTheme.headline1,
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Icon(
//               Icons.notifications,
//               size: 32,
//             ),
//           ),
//         ],
//         backgroundColor: Colors.white,
//         flexibleSpace: FlexibleSpaceBar(
//           collapseMode: CollapseMode.pin,
//           background: Container(
//             decoration: BoxDecoration(
//               gradient: blueGradient,
//               borderRadius: BorderRadius.vertical(
//                 bottom:
//                     Radius.elliptical(MediaQuery.of(context).size.width, 170),
//               ),
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: blueGradient,
//                 borderRadius: BorderRadius.vertical(
//                   bottom:
//                       Radius.elliptical(MediaQuery.of(context).size.width, 170),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }