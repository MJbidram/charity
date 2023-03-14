import 'package:charity/bloc/factors_bloc/factors_bloc.dart';
import 'package:charity/bloc/factors_bloc/factors_event.dart';
import 'package:charity/bloc/factors_bloc/factors_state.dart';
import 'package:charity/constants/constants.dart';

import 'package:charity/models/factors_model.dart';
import 'package:charity/util/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/spin_kit.dart';

bool filterFactors = false;

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
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 16),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: 50,
                  color: blueDark,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(children: [
                      Text(
                        'نمایش پرداخت های ناموفق',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const Spacer(),
                      Switch(
                        value: filterFactors,
                        onChanged: (value) {
                          setState(() {
                            filterFactors = value;
                          });

                          context.read<FactorsBloc>().add(
                              FactorRequestListEvent(
                                  AuthManager.authChangeNotifire.value));
                        },
                      )
                    ]),
                  ),
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
                    if (!filterFactors) {
                      List<FactorsModle> sucseeslist = [];
                      sucseeslist = r.where((element) {
                        return element.isPardakht == 1;
                      }).toList();
                      return FactoersList(
                        factorsModel: sucseeslist,
                      );
                    } else {
                      List<FactorsModle> unsucseeslist = [];
                      unsucseeslist = r.where((element) {
                        return element.isPardakht == 0;
                      }).toList();
                      return FactoersList(
                        factorsModel: unsucseeslist,
                      );
                    }
                    // return FactoersList(
                    //   factorsModel: r,
                    // );
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

class FactoersList extends StatefulWidget {
  List<FactorsModle> factorsModel;
  FactoersList({
    Key? key,
    required this.factorsModel,
  }) : super(key: key);

  @override
  State<FactoersList> createState() => _FactoersListState();
}

class _FactoersListState extends State<FactoersList> {
  List<FactorsModle> factorsModel = [];

  @override
  void initState() {
    factorsModel = widget.factorsModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          // final reversedIndex = factorsModel.length;
          final reversedIndex = factorsModel.length - index - 1;
          return listBody(context, reversedIndex);
        },
        childCount: factorsModel.length,
      ),
    );
  }

  Stack listBody(BuildContext context, int reversedIndex) {
    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 8, right: 16, left: 16),
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
                            : factorsModel[reversedIndex].resNum.toString() ==
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      filterFactors == true
                          ? Container(
                              height: 42.0,
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32)),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      foregroundColor: blueLight,
                                      backgroundColor: blueDark),
                                  onPressed: () async {
                                    try {
                                      await launchUrl(
                                          Uri.parse(ApiAddress.repayLink +
                                              factorsModel[reversedIndex]
                                                  .sabtId),
                                          mode: LaunchMode
                                              .externalNonBrowserApplication);
                                    } catch (e) {
                                      print('خطا در باز کردن مرورگر');
                                    }
                                  },
                                  child: Text(
                                    'پرداخت',
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  )),
                            )
                          : Container(),
                      const Spacer(),
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
                                'فاکتور پرداخت : khapp.kheiriehemamali.ir/fk/${factorsModel[reversedIndex].sabtId}');
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
                    ],
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
  }

  void filterList(int ispardakht) {
    List<FactorsModle> _factorfilterResult = [];
    _factorfilterResult = widget.factorsModel.where((element) {
      return element.isPardakht == 0;
    }).toList();
    setState(() {
      widget.factorsModel = _factorfilterResult;
    });
  }
}
