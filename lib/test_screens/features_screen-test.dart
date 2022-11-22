import 'package:charity/constants/constants.dart';
import 'package:flutter/material.dart';

class MyfeaturesTest extends StatelessWidget {
  const MyfeaturesTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Center(
        child: ListView.builder(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: _getIcons2(),
            );
          },
          itemCount: 6,
        ),
      ),
    );
  }

  Widget _getIcons1() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.sim_card,
              color: Colors.white,
              size: 28,
            ),
            // AssetImage('images/logo.png'),
          ),
          Text(
            'test',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIcons2() {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: blueLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.sim_card,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        Text(
          'test',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ]),
    );
  }

  Widget _getGridview() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return _getIcons2();
      }),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
          mainAxisExtent: 100),
    );
  }
}
