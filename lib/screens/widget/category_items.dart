import 'package:flutter/material.dart';

class CategoryHorizantalItems extends StatelessWidget {
  const CategoryHorizantalItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 54,
          width: 54,
          decoration: ShapeDecoration(
            shadows: const [
              BoxShadow(
                color: Colors.red,
                blurRadius: 25,
                spreadRadius: -12,
                offset: Offset(0.0, 16),
              ),
            ],
            color: Colors.red,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: const Icon(
            Icons.mouse,
            size: 32,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'همه',
          style: TextStyle(fontFamily: 'SB'),
        ),
      ],
    );
  }
}
