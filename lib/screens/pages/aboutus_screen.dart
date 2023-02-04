import 'package:charity/bloc/aboutus_bloc/aboutus_bloc.dart';
import 'package:charity/bloc/aboutus_bloc/aboutus_event.dart';
import 'package:charity/bloc/aboutus_bloc/aboutus_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/models/aboutus_model.dart';
import 'package:charity/screens/widget/error_box.dart';
import 'package:charity/screens/widget/spin_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    BlocProvider.of<AboutUsBloc>(context).add(AboutUsLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverAppBar(
            title: Text(shortName),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            pinned: false,
            expandedHeight: AppBar().preferredSize.height + 70,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    height: AppBar().preferredSize.height + 40,
                    decoration: BoxDecoration(
                      gradient: blueGradient,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 150),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<AboutUsBloc, AboutUsState>(
            builder: (context, state) {
              if (state is AboutUsInitState) {
                return const SliverToBoxAdapter(
                  child: Center(child: MySpinKit()),
                );
              }
              if (state is AboutUsLoadedState) {
                return state.response.fold((l) {
                  return SliverToBoxAdapter(
                    child: Center(
                        child: ErrorBox(
                      errorMessage: l,
                      onTap: () {
                        context.read<AboutUsBloc>().add(AboutUsLoadEvent());
                      },
                    )),
                  );
                }, (r) {
                  return body(r);
                });
              } else {
                return SliverToBoxAdapter(
                  child: Center(
                      child: ErrorBox(
                    errorMessage: 'خطا در دریافت اطلاعات از سرور',
                    onTap: () {
                      context.read<AboutUsBloc>().add(AboutUsLoadEvent());
                    },
                  )),
                );
              }
            },
          ),
        ]),
      ),
    );
  }

  Widget body(AboutUsModel aboutUsModel) {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 8),
      sliver: SliverToBoxAdapter(
        child: Center(
            child: Column(
          children: [
            Text(aboutUsModel.fullname ??
                aboutUsModel.shortname ??
                'خیریه امام علی'),
            const SizedBox(
              height: 4,
            ),
            Html(
              data: aboutUsModel.about,
            ),
            const SizedBox(
              height: 4,
            ),
            const Text('تلفن:'),
            Text(aboutUsModel.phone ?? 'شماره تلفن موجود نیست'),
          ],
        )),
      ),
    );
    // SliverPadding(
    //   padding: EdgeInsets.only(bottom: 8),
    //   sliver: SliverToBoxAdapter(
    //     child: Center(child: Text('درباره خیریه')),
    //   ),
    // ),
    // SliverPadding(
    //   padding: EdgeInsets.only(bottom: 4),
    //   sliver: SliverToBoxAdapter(
    //     child: Center(child: Text('تلفن:')),
    //   ),
    // ),
    // SliverPadding(
    //   padding: EdgeInsets.only(bottom: 8),
    //   sliver: SliverToBoxAdapter(
    //     child: Center(child: Text('۰۹۱۲۳۴۵۶۷۸۹')),
    //   ),
    // ),
  }
}
