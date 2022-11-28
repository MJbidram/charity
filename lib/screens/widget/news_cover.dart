import 'package:charity/constants/constants.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return _getCoevrNews(context);
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
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          height: 200,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Image(
                    image: AssetImage(
                      'assets/images/item15.jpg',
                    ),
                  ),
                  Text('عنوان خبر در این جا قرار دارد'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GetWidgetCover {}
