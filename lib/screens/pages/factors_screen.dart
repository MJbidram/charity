import 'package:charity/bloc/factors_bloc/factors_bloc.dart';
import 'package:charity/bloc/factors_bloc/factors_event.dart';
import 'package:charity/bloc/factors_bloc/factors_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/data/repository/factors_repository.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/factors_model.dart';
import 'package:charity/util/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:share_plus/share_plus.dart';

import '../widget/spin_kit.dart';

class FactorsScreen extends StatefulWidget {
  const FactorsScreen({super.key});

  @override
  State<FactorsScreen> createState() => _FactorsScreenState();
}

class _FactorsScreenState extends State<FactorsScreen> {
  @override
  void initState() {
    BlocProvider.of<FactorsBloc>(context)
        .add(FactorRequestListEvent(AuthManager.authChangeNotifire.value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
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
            BlocBuilder<FactorsBloc, FactorsState>(
              builder: (context, state) {
                if (state is FactorsLoadingState) {
                  return const SliverToBoxAdapter(
                    child: Center(child: MySpinKit()),
                  );
                }
                if (state is FactorsLoadedState) {
                  return state.response.fold((l) {
                    return Text(l);
                  }, (r) {
                    return FactoersList(
                      factorsModel: r,
                    );
                  });
                }
                return const SliverToBoxAdapter(child: Text('error'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FactoersList extends StatelessWidget {
  List<FactorsModle> factorsModel;
  FactoersList({
    Key? key,
    required this.factorsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final reversedIndex = factorsModel.length - index - 1;
          return Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 8, right: 16, left: 16),
                  child: Container(
                    height: 212.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        gradient: blueGradient),
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      child: Column(children: [
                        Row(
                          children: [
                            Text(
                              'مبلغ',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            const Spacer(),
                            Text(
                              '${factorsModel[reversedIndex].amunt.toString().toPersianDigit().seRagham()} تومان',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              'بابت',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            const Spacer(),
                            Text(
                              factorsModel[reversedIndex].title.toString(),
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              'شماره پیگیری',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            const Spacer(),
                            Text(
                              factorsModel[reversedIndex].isPardakht == 1
                                  ? factorsModel[reversedIndex]
                                      .resNum
                                      .toString()
                                      .toPersianDigit()
                                  : factorsModel[reversedIndex]
                                              .resNum
                                              .toString() ==
                                          'null'
                                      ? 'خطا در عملیات پرداخت'
                                      : factorsModel[reversedIndex]
                                          .resNum
                                          .toString()
                                          .toPersianDigit(),
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              ' تاریخ تراکنش',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            const Spacer(),
                            Text(
                              factorsModel[reversedIndex]
                                      .updatedAt
                                      ?.substring(0, 10)
                                      .toPersianDate() ??
                                  'خطا ',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 42.0,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                foregroundColor: blueLight,
                                backgroundColor: blueDark),
                            onPressed: () {
                              Share.share(
                                  'فاکتور پرداخت : khapp.kheiriehemamali.ir/fk/110-kdbveh');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.share_outlined,
                                  color: white,
                                  size: 28,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: CircleAvatar(
                    backgroundColor: blueDark,
                    radius: 24.0,
                    child: factorsModel[reversedIndex].isPardakht == 1
                        ? const Icon(
                            Icons.done_rounded,
                            size: 28,
                            color: Colors.greenAccent,
                          )
                        : const Icon(
                            Icons.close,
                            size: 28,
                            color: Colors.redAccent,
                          )),
              ),
            ],
          );
        },
        childCount: factorsModel.length,
      ),
    );
  }
}
