import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:charity/bloc/followup_bloc/followup_bloc.dart';
import 'package:charity/bloc/followup_bloc/followup_event.dart';
import 'package:charity/bloc/followup_bloc/followup_state.dart';
import 'package:charity/models/damand_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../constants/constants.dart';
import '../widget/error_box.dart';
import '../widget/spin_kit.dart';

class FollowUpDamandScreen extends StatefulWidget {
  const FollowUpDamandScreen({super.key});

  @override
  State<FollowUpDamandScreen> createState() => _FollowUpDamandScreenState();
}

class _FollowUpDamandScreenState extends State<FollowUpDamandScreen> {
  @override
  void initState() {
    BlocProvider.of<FollowUpDamandBloc>(context).add(FollowUpLoadEvent());
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
            // SliverPadding(
            //   padding: EdgeInsets.only(bottom: 16),
            //   sliver: SliverToBoxAdapter(
            //     child: Container(
            //       height: 50,
            //       color: blueDark,
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 16),
            //         child: Row(children: [
            //           Text(
            //             'نمایش پرداخت های ناموفق',
            //             style: Theme.of(context).textTheme.headline2,
            //           ),
            //           Spacer(),
            //           Switch(
            //             value: filterFactors,
            //             onChanged: (value) {
            //               setState(() {
            //                 filterFactors = value;
            //               });

            //               context.read<FactorsBloc>().add(
            //                   FactorRequestListEvent(
            //                       AuthManager.authChangeNotifire.value));
            //             },
            //           )
            //         ]),
            //       ),
            //     ),
            //   ),
            // ),
            BlocBuilder<FollowUpDamandBloc, FollowUpState>(
              builder: (context, state) {
                if (state is FollowUpInitState) {
                  return const SliverToBoxAdapter(
                    child: Center(child: MySpinKit()),
                  );
                }
                if (state is FollowUpLoadedState) {
                  return state.response.fold((l) {
                    return SliverToBoxAdapter(
                      child: ErrorBox(
                        errorMessage: l,
                        onTap: () {
                          context
                              .read<FollowUpDamandBloc>()
                              .add(FollowUpLoadEvent());
                        },
                      ),
                    );
                  }, (r) {
                    if (r.length == 0) {
                      return const SliverToBoxAdapter(
                        child: Center(child: Text('درخواستی ثبت نشده است')),
                      );
                    } else {
                      return FactoersList(damandListModel: r);
                    }
                  });
                }
                if (state is FollowUpDeleteState) {
                  return state.response.fold((l) {
                    return SliverToBoxAdapter(
                      child: ErrorBox(
                        errorMessage: 'خطا در حذف درخواست',
                        onTap: () {
                          context
                              .read<FollowUpDamandBloc>()
                              .add(FollowUpLoadEvent());
                        },
                      ),
                    );
                  }, (r) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      AwesomeDialog(
                              context: context,
                              animType: AnimType.scale,
                              dialogType: DialogType.success,
                              body: const Center(
                                child: Text(
                                  'درخواست شما با موفقیت حذف شد',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              title: 'حذف',
                              desc: '',
                              btnOkOnPress: () {
                                context
                                    .read<FollowUpDamandBloc>()
                                    .add(FollowUpLoadEvent());
                              },
                              btnOkText: 'فهمیدم')
                          .show();
                    });
                    return const SliverToBoxAdapter(
                      child: Center(
                          child: Text(
                        'حذف درخواست موفقیت آمیز بود',
                      )),
                    );
                  });
                } else {
                  return SliverToBoxAdapter(
                    child: ErrorBox(
                      errorMessage: 'خطا',
                      onTap: () {
                        context
                            .read<FollowUpDamandBloc>()
                            .add(FollowUpLoadEvent());
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FactoersList extends StatefulWidget {
  List<DamandListModle> damandListModel;
  FactoersList({
    Key? key,
    required this.damandListModel,
  }) : super(key: key);

  @override
  State<FactoersList> createState() => _FactoersListState();
}

class _FactoersListState extends State<FactoersList> {
  List<DamandListModle> damandListModel = [];

  @override
  void initState() {
    damandListModel = widget.damandListModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          // final reversedIndex = factorsModel.length;
          final reversedIndex = damandListModel.length - index - 1;
          return listBody(context, reversedIndex);
        },
        childCount: damandListModel.length,
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
                        'موضوع درخواست',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const Spacer(),
                      Text(
                        '${damandListModel[reversedIndex].title}',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        'توضیحات',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const Spacer(),
                      Text(
                        damandListModel[reversedIndex].description.toString(),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        'وضعیت درخواست',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const Spacer(),
                      Text(
                        damandListModel[reversedIndex].status.toString(),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        ' تاریخ ایجاد درخواست',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const Spacer(),
                      Text(
                        // damandListModel[reversedIndex].date != null
                        //     ? damandListModel[reversedIndex]
                        //         .date!
                        //         .substring(0, 10)
                        //         .toPersianDate()
                        //     :
                        'تاریخی ثبت نشده است',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                            onPressed: () async {
                              context.read<FollowUpDamandBloc>().add(
                                  FollowUpDeletEvent(
                                      damandListModel[reversedIndex]
                                          .id
                                          .toString()));
                            },
                            child: Text(
                              'حذف ',
                              style: Theme.of(context).textTheme.headline2,
                            )),
                      ),
                      // Spacer(),
                      // Container(
                      //   height: 42.0,
                      //   width: MediaQuery.of(context).size.width / 3,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(32)),
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //         elevation: 0,
                      //         foregroundColor: blueLight,
                      //         backgroundColor: blueDark),
                      //     onPressed: () {},
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Icon(
                      //           Icons.share_outlined,
                      //           color: white,
                      //           size: 28,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ),
        // Align(
        //   alignment: AlignmentDirectional.topCenter,
        //   child: CircleAvatar(
        //       backgroundColor: blueDark,
        //       radius: 24.0,
        //       child:
        //           //factorsModel[reversedIndex].isPardakht == 1
        //           //     ? const Icon(
        //           //         Icons.done_rounded,
        //           //         size: 28,
        //           //         color: Colors.greenAccent,
        //           //       )
        //           //     :
        //           const Icon(
        //         Icons.close,
        //         size: 28,
        //         color: Colors.redAccent,
        //       )),
        // ),
      ],
    );
  }
}
