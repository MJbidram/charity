import 'package:charity/constants/constants.dart';
import 'package:charity/models/models.dart';
import 'package:charity/screens/pages/news_screen.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  News({
    super.key,
  });

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => _getCoevrNews(context),
    );
  }

  Widget _getCoevrNews(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MyNewsPage()));
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
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'تیتر خبر در اینجا قرار دارد',
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: Image.asset(
                      'assets/images/item10.jpg',
                      fit: BoxFit.cover,
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
