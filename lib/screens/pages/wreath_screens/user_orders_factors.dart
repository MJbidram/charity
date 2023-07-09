import 'package:charity/bloc/userorder_bloc/userbloc.dart';
import 'package:charity/bloc/userorder_bloc/userbloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../bloc/userorder_bloc/userblo_event.dart';
import '../../../constants/constants.dart';
import '../../../models/user_orders_model.dart';
import '../../widget/error_box.dart';
import '../../widget/spin_kit.dart';

class UserOrderScreen extends StatefulWidget {
  const UserOrderScreen({super.key});

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  @override
  void initState() {
    BlocProvider.of<UserOrdersBloc>(context).add(UserOrderRequestListEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<UserOrdersBloc, UserOrderState>(builder: (context, state) {
      if (state is UserOrderLoadingState) {
        return Center(
          child: MySpinKit(),
        );
      }
      if (state is UserOrderLoadedState) {
        return state.response.fold((l) {
          return ErrorBox(
            errorMessage: l,
            onTap: () {
              BlocProvider.of<UserOrdersBloc>(context)
                  .add(UserOrderRequestListEvent());
            },
          );
        }, (r) {
          return CustomScrollView(
            slivers: [
              _getAppBar(context),
              listCreator(r),
            ],
          );
        });
      } else {
        return Center(
          child: ErrorBox(
            errorMessage: 'خطا',
            onTap: () {
              BlocProvider.of<UserOrdersBloc>(context)
                  .add(UserOrderRequestListEvent());
            },
          ),
        );
      }
    }));
  }

  SliverList listCreator(List<UserOrdersModel> userorder) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return listBody(context, index, userorder[index]);
        },
        childCount: userorder.length,
      ),
    );

    // ListView.builder(
    //   itemBuilder: (context, index) {
    //     return listBody(context, index, userorder[index]);
    //   },
    //   itemCount: userorder.length,
    // );
  }

  Stack listBody(
      BuildContext context, int reversedIndex, UserOrdersModel userorder) {
    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 8, right: 16, left: 16),
            child: Container(
              height: 200.0,
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
                        'از طرف',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Spacer(),
                      Text(
                        // '${factorsModel[reversedIndex].amunt.toString().toPersianDigit().seRagham()} تومان',
                        userorder.bename,
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
                        'وضعیت',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Spacer(),
                      Text(
                        userorder.status!,
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
                        'نام مرحوم',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Spacer(),
                      Text(
                        userorder.marhoomName,
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
                        ' تاریخ سفارش',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Spacer(),
                      Text(
                        // factorsModel[reversedIndex]
                        //         .updatedAt
                        //         ?.substring(0, 10)
                        //         .toPersianDate() ??
                        //     'خطا ',
                        userorder.createdAt.toPersianDate(),
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
                        'وضعیت پرداخت',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Spacer(),
                      Text(
                        userorder.isPardakht == 0
                            ? 'پرداخت نشده'
                            : 'پرداخت شده',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     // filterFactors == true
                  //     //     ? Container(
                  //     //         height: 42.0,
                  //     //         width: MediaQuery.of(context).size.width / 3,
                  //     //         decoration: BoxDecoration(
                  //     //             borderRadius: BorderRadius.circular(32)),
                  //     //         child: ElevatedButton(
                  //     //             style: ElevatedButton.styleFrom(
                  //     //                 elevation: 0,
                  //     //                 foregroundColor: blueLight,
                  //     //                 backgroundColor: blueDark),
                  //     //             onPressed: () async {
                  //     //               try {
                  //     //                 await launchUrl(
                  //     //                     Uri.parse(ApiAddress.repayLink +
                  //     //                         factorsModel[reversedIndex]
                  //     //                             .sabtId),
                  //     //                     mode: LaunchMode
                  //     //                         .externalNonBrowserApplication);
                  //     //               } catch (e) {
                  //     //                 print('خطا در باز کردن مرورگر');
                  //     //               }
                  //     //             },
                  //     //             child: Text(
                  //     //               'پرداخت',
                  //     //               style:
                  //     //                   Theme.of(context).textTheme.headline2,
                  //     //             )),
                  //     //       )
                  //     //     : Container(),
                  //     const Spacer(),
                  //     Container(
                  //       height: 42.0,
                  //       width: MediaQuery.of(context).size.width / 3,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(32)),
                  //       child: ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //             elevation: 0,
                  //             foregroundColor: blueLight,
                  //             backgroundColor: blueDark),
                  //         onPressed: () {
                  //           // Share.share(
                  //           //     'فاکتور پرداخت : khapp.kheiriehemamali.ir/fk/${factorsModel[reversedIndex].sabtId}');
                  //         },
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Icon(
                  //               Icons.share_outlined,
                  //               color: white,
                  //               size: 28,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
        //       child: factorsModel[reversedIndex].isPardakht == 1
        //           ? const Icon(
        //               Icons.done_rounded,
        //               size: 28,
        //               color: Colors.greenAccent,
        //             )
        //           : const Icon(
        //               Icons.close,
        //               size: 28,
        //               color: Colors.redAccent,
        //             )),
        // ),
      ],
    );
  }

  SliverAppBar _getAppBar(BuildContext context) {
    return SliverAppBar(
      title: Text('تاج گل های سفارش داده شده'),
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
