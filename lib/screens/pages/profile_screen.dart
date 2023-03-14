import 'package:charity/bloc/aboutus_bloc/aboutus_bloc.dart';
import 'package:charity/bloc/factors_bloc/factors_bloc.dart';
import 'package:charity/bloc/followup_bloc/followup_bloc.dart';
import 'package:charity/bloc/profile_bloc/profle_bloc.dart';
import 'package:charity/bloc/profile_bloc/profle_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/main.dart';
import 'package:charity/screens/pages/aboutus_screen.dart';
import 'package:charity/screens/pages/editProfile_screen.dart';
import 'package:charity/screens/pages/factors_screen.dart';
import 'package:charity/screens/pages/login_screen.dart';
import 'package:charity/screens/widget/spin_kit.dart';
import 'package:charity/util/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:url_launcher/url_launcher.dart';
import '../../bloc/profile_bloc/profile_event.dart';
import '../../bloc/profile_edit_bloc/profile_edit_bloc.dart';

import 'followup_damand_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    BlocProvider.of<ProfielBloc>(context).add(LoadProfleEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProfielBloc>().add(LoadProfleEvent());
    return SafeArea(
      child: Scaffold(
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
                    child: BlocBuilder<ProfielBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileInitState) {
                      return const MySpinKit();
                    }
                    if (state is ProfileLoadedState) {
                      return state.response.fold((l) {
                        return Text(l);
                      }, (r) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                r.name,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Text(
                                r.phone,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ]);
                      });
                    } else {
                      return const Text('خطا در دریافت مشخصات');
                    }
                  },
                ))),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BlocProvider(
                          create: (context) => PorfileEditBloc(),
                          child: const ProfileEditScreen(),
                        );
                      }));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 45),
                          child: Text(
                            'ویرایش پروفایل',
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
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BlocProvider(
                          create: (context) => FollowUpDamandBloc(),
                          child: const FollowUpDamandScreen(),
                        );
                      }));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 45),
                          child: Text(
                            'پیگیری وضعیت درخواست ها',
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
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BlocProvider(
                          create: (context) => AboutUsBloc(),
                          child: const AboutUsScreen(),
                        );
                      }));
                    },
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
                    onPressed: () async {
                      final Uri launchUri = Uri(
                        scheme: 'tel',
                        path: phoneNumber,
                      );
                      await launchUrl(
                        launchUri,
                      );

                      // await launch(launchUri.toString());
                    },
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
      ),
    );
  }
}
