import 'package:charity/constants/constants.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return _getNewsList();
  }

  Widget _getNewsList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _getCoevrNews(context);
      },
    );
  }

  Widget _getCoevrNews(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          height: 200,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Stack(children: [
            Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: blueLight,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Container(
                margin: EdgeInsets.only(right: 20, bottom: 12),
                height: 188,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  color: blueDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('تصویر'),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Container(
                color: Colors.transparent,
                height: 150,
                width: MediaQuery.of(context).size.width -
                    (MediaQuery.of(context).size.width / 3) -
                    20,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('تیتر خبر'),
                        Text(
                          'خلاصه خبر',
                          style: TextStyle(fontSize: 18),
                        ),
                      ]),
                ),
              ),
            )
          ]),
        ),
      ],
    );
  }
}

class GetWidgetCover {}
