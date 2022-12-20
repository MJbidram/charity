import 'package:charity/constants/constants.dart';
import 'package:charity/models/models.dart';
import 'package:charity/screens/pages/news_screen.dart';
import 'package:flutter/material.dart';

import '../../bloc/home_bloc/home_state.dart';

class News extends StatefulWidget {
  News({
    super.key,
    required this.index,
    required this.state,
  });
  final int index;
  final HomeLoadedState state;
  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late final int index;
  late final HomeLoadedState state;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.index;
    state = widget.state;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => _getCoevrNews(context),
    );
  }

  Widget _getCoevrNews(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.of(context)
      //       .push(MaterialPageRoute(builder: (context) => NewsScreen()));
      // },
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
                        state.newsModl[index].newsTitile,
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
                    child: Image.network(
                      state.newsModl[index].newsImageUrl,
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
