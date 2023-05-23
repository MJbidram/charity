import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../constants/constants.dart';

class ReserveWreathScreen extends StatelessWidget {
  const ReserveWreathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _getAppBar(context),
          _getTitle(context),
          _getImage(),
          _getBody(context),
        ],
      ),
    );
  }

  SliverPadding _getBody(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            const Text(
                'توضیحات و راهنمای سفارش تاج گل در این بخش قرار خواهد گرفت.'),
            const SizedBox(
              height: 64,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blueDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {},
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'ثبت سفارش',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 24,
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blueLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {},
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'پیگیری سفارش',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Icons.find_in_page_outlined,
                    size: 24,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverPadding _getImage() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      sliver: SliverToBoxAdapter(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/item16.jpg',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  SliverPadding _getTitle(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Text(
            'سفارش تاج گل',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
    );
  }

  SliverAppBar _getAppBar(BuildContext context) {
    return SliverAppBar(
      title: Text(shortName),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      pinned: false,
      expandedHeight: AppBar().preferredSize.height + 30,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: blueGradient,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(MediaQuery.of(context).size.width, 170),
            ),
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
