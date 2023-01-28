import 'package:charity/bloc/factors_bloc/factors_bloc.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/main.dart';
import 'package:charity/screens/pages/factors_screen.dart';
import 'package:charity/screens/pages/login_screen.dart';
import 'package:charity/util/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('information');

    return Scaffold(
      extendBody: true,
      backgroundColor: grey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(shortName),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            pinned: false,
            expandedHeight: AppBar().preferredSize.height + 100,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    height: AppBar().preferredSize.height + 70,
                    decoration: BoxDecoration(
                      gradient: blueGradient,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 170),
                      ),
                    ),
                  ),
                  Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: const BoxDecoration(
                                // color: Colors.amber,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 70,
                                color: Colors.grey,
                              ),
                            ),
                          ))),
                ],
              ),
            ),
          ),
          SliverPadding(
              padding: const EdgeInsets.only(top: 8, bottom: 32),
              sliver: SliverToBoxAdapter(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        box.get('name') ?? 'ناشناس',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        box.get('phone') ?? '__',
                        style: Theme.of(context).textTheme.headline6,
                      )
                    ]),
              )),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextButton(
                //   onPressed: () {},
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(right: 45),
                //         child: Text(
                //           'ویرایش پروفایل',
                //           style: Theme.of(context).textTheme.headline6,
                //           textAlign: TextAlign.start,
                //         ),
                //       ),
                //       const Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 40),
                //         child: Divider(
                //           color: Colors.grey,
                //           height: 15,
                //           thickness: 1,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // TextButton(
                //   onPressed: () {},
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(right: 45),
                //         child: Text(
                //           'تغییر رمز ورود',
                //           style: Theme.of(context).textTheme.headline6,
                //           textAlign: TextAlign.start,
                //         ),
                //       ),
                //       const Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 40),
                //         child: Divider(
                //           color: Colors.grey,
                //           height: 15,
                //           thickness: 1,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BlocProvider(
                        create: (context) => FactorsBloc(),
                        child: const FactorsScreen(),
                      );
                    }));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 45),
                        child: Text(
                          'لیست پرداخت ها ',
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Divider(
                          color: Colors.grey,
                          height: 15,
                          thickness: 1,
                        ),
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 45),
                        child: Text(
                          'درباره ما ',
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Divider(
                          color: Colors.grey,
                          height: 15,
                          thickness: 1,
                        ),
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 45),
                        child: Text(
                          'ارتباط با ما ',
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Divider(
                          color: Colors.grey,
                          height: 15,
                          thickness: 1,
                        ),
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await AuthManager.logout();

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 45),
                        child: Text(
                          'خروج ',
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Divider(
                          color: Colors.grey,
                          height: 15,
                          thickness: 1,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
