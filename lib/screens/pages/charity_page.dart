import 'package:charity/constants/constants.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class CharityPage extends StatelessWidget {
  const CharityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: _const_appbar(context),
      body: _getCharityPageBody(),
    );
  }

  PreferredSize _const_appbar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(250),
      child: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 16.0),
            child: Text(
              'خیریه امام علی (ع) شهر گرگاب',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ],
        leading: Icon(
          Icons.notifications,
          size: 32,
        ),
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
                    'assets/images/item15.png',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getCharityPageBody() {
    return Column(
      children: [
        Text('data'),
      ],
    );
  }
}
