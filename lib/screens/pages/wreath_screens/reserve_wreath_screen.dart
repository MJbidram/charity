import 'package:charity/screens/pages/wreath_screens/user_orders_factors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/maresemat_bloc/marasemat_bloc.dart';
import '../../../bloc/userorder_bloc/userbloc.dart';
import '../../../constants/constants.dart';
import 'choose_event_screen.dart';

class ReserveWreathScreen extends StatelessWidget {
  const ReserveWreathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _getAppBar(context),
          // _getTitle(context),
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
                'با این سرویس می توانید در مراسمات ترحیم پیش رو به نام دلخواه تاج گل قرار دهید . هزینه های دریافتی صرف امور خیر می شوند و هم شما و مرحوم از ثواب آن بهرمند می شوید .'),
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => MarasematBloc(),
                          child: ChooseEventScreen(),
                        ),
                      ));
                },
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => UserOrdersBloc(),
                          child: UserOrderScreen(),
                        ),
                      ));
                },
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
            'assets/images/item9.jpg',
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
      title: Text('سفارش تاج گل'),
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
