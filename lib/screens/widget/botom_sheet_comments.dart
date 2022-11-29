import 'dart:ui';

import 'package:charity/constants/constants.dart';
import 'package:flutter/material.dart';

class BottomSheetComments extends StatelessWidget {
  const BottomSheetComments({super.key, this.controller});
  final ScrollController? controller;
  @override
  Widget build(BuildContext context) {
    return _getBottomSheet(context);
  }

  Widget _getBottomSheet(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(36),
        topRight: Radius.circular(36),
      ),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(102, 204, 204, 204),
              Color.fromARGB(102, 143, 143, 143),
            ])),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: _getItems(context),
          ),
        ),
      ),
    );
  }

  Widget _getItems(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
      CustomScrollView(
        controller: controller,
        slivers: [
          SliverToBoxAdapter(
            child: _getHeader(context),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _getItemComment();
              },
              childCount: 20,
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 110))
        ],
      ),
    ]);
  }

  Widget _getHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 22),
          height: 5,
          width: 67,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: white),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('دیدگاه ها', style: Theme.of(context).textTheme.headline5),
            Icon(Icons.question_answer_outlined),
          ],
        ),
        SizedBox(
          height: 32,
        ),
        Container(
          height: 46,
          width: 340,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: Color.fromRGBO(255, 255, 255, 0.4),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Expanded(
                  child: TextField(
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      hintText: 'نوشتن دیدگاه ...',
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                IconButton(
                  alignment: AlignmentDirectional.centerStart,
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                    textDirection: TextDirection.rtl,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 32,
        )
      ],
    );
  }

  Widget _getItemComment() {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/item10.png'),
        ),
        SizedBox(
          width: 8,
        ),
        Container(
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'محمدجواد',
                style: TextStyle(
                  color: blueDark,
                  fontFamily: 'VB',
                  fontSize: 14,
                ),
                textDirection: TextDirection.rtl,
              ),
              Text(
                textDirection: TextDirection.rtl,
                ' نظر متن نظر متن نظ نظر متن نظر متن نظمتن نظر متن نظ نظر متن نظر متن نظمتن نظر متن نظ نظر متن نظر متن نظمتن نظر متن نظر متن نظر',
                style: TextStyle(
                  color: blueDark,
                  fontFamily: 'VL',
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'زمان انتشار',
                style:
                    TextStyle(color: blueLight, fontFamily: 'VL', fontSize: 12),
              ),
              const Divider(
                height: 20,
                thickness: 0.5,
                indent: 20,
                endIndent: 0,
                color: Color(0xff1d3557),
              ),
              SizedBox(
                height: 4,
              )
            ],
          ),
        )
      ],
    );
  }
}
