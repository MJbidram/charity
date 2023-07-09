import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:charity/bloc/further_information_bloc/further_info_bloc.dart';
import 'package:charity/bloc/further_information_bloc/further_info_event.dart';
import 'package:charity/bloc/further_information_bloc/further_info_state.dart';
import 'package:charity/models/listofnames_model.dart';
import 'package:charity/models/wreath_tarh_model.dart';
import 'package:charity/screens/pages/wreath_screens/user_orders_factors.dart';
import 'package:charity/screens/widget/error_box.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:uni_links/uni_links.dart';

import '../../../bloc/maresemat_bloc/marasemat_bloc.dart';
import '../../../constants/constants.dart';
import '../../../models/wreath_types_model.dart';
import '../../widget/spin_kit.dart';

int wearthTypeSelectedItem = 0;
int wearthTarhSelectedItem = 0;
List<ListOfNamesModel> listOfNames = [];
TextEditingController textfildController = TextEditingController();
WearthTypeModel? typeModel;

class FurtherInformationScreen extends StatefulWidget {
  FurtherInformationScreen(this.eventId, {super.key});
  // List<String>? names;
  int eventId;

  @override
  State<FurtherInformationScreen> createState() =>
      _FurtherInformationScreenState();
}

class _FurtherInformationScreenState extends State<FurtherInformationScreen> {
  @override
  void initState() {
    linkStream.listen((deepLink) {
      if (deepLink!.toLowerCase().contains('kheyriehemamali')) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => MarasematBloc(),
                child: UserOrderScreen(),
              ),
            ));
      }
    });
    BlocProvider.of<FurtherInfoBloc>(context).add(GetFurtherInfoEvent());
    super.initState();
  }

  int typeId = 0;
  int tarhId = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FurtherInfoBloc, FurtherInfoState>(
          builder: (context, state) {
        if (state is LoadingFurtherInfoState) {
          return const Center(
            child: MySpinKit(),
          );
        }
        if (state is FurtherInfoLoadedState) {
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  _getAppBar(context),
                  _getNameTextFildandTitle(context),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          state.type.fold((l) {
                            return SliverToBoxAdapter(
                              child: ErrorBox(
                                errorMessage: l,
                                onTap: () {
                                  BlocProvider.of<FurtherInfoBloc>(context)
                                      .add(GetFurtherInfoEvent());
                                },
                              ),
                            );
                          }, (r) {
                            typeModel = r;
                            return _getButton(
                                context, 'انتخاب تاج گل', Icons.local_florist,
                                () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: DialogType.noHeader,
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                body: Column(
                                  children: [
                                    const Text(
                                      'نوع تاج گل را انتخاب کنید',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                    getTypeGallery(
                                      wearthTypeModel: r,
                                    ),
                                  ],
                                ),
                                // btnOk: ElevatedButton(
                                //   onPressed: () {
                                //     typeId =
                                //         r.data[wearthTypeSelectedItem].id;
                                //   },
                                //   child: Text('انتخاب'),
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor: blueDark,
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(16),
                                //     ),
                                //   ),
                                // )
                                btnOkOnPress: () {
                                  typeId = r.data[wearthTypeSelectedItem].id;
                                  print(typeId);
                                },
                              ).show();
                            });
                          }),
                          ///////////////////
                          ////// tarh //////
                          /////////////////

                          state.tarh.fold((l) {
                            return SliverToBoxAdapter(
                              child: ErrorBox(
                                errorMessage: l,
                                onTap: () {
                                  BlocProvider.of<FurtherInfoBloc>(context)
                                      .add(GetFurtherInfoEvent());
                                },
                              ),
                            );
                          }, (r) {
                            return _getButton(
                                context, 'انتخاب طرح', Icons.brush, () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: DialogType.noHeader,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                body: Column(
                                  children: [
                                    const Text(
                                      'طرح تاج گل را انتخاب کنید',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                    GetTarhGallery(wearthTarheModel: r),
                                  ],
                                ),
                                title: 'This is Ignored',
                                desc: 'This is also Ignored',
                                btnOkOnPress: () {
                                  tarhId = r.data[wearthTarhSelectedItem].id;
                                },
                                btnOkText: 'انتخاب',
                                btnOkColor: blueDark,
                                // btnOk: ElevatedButton(
                                //   onPressed: () {
                                //     tarhId = r.data[wearthTarhSelectedItem].id;
                                //   },
                                //   child: Text('انتخاب'),
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor: blueDark,
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(16),
                                //     ),
                                //   ),
                                // ),
                              ).show();
                            });
                          }),
                        ],
                      ),
                    ),
                  ),

                  // SliverToBoxAdapter(child: getGallery()),
                  // SliverToBoxAdapter(
                  //     child: Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 32),
                  //   child: _getButton(context, 'افزودن', Icons.add, () {
                  //     if (textfildController.text == '') {
                  //       AwesomeDialog(
                  //         context: context,
                  //         body: const Center(
                  //           child: Text('یک نام معتبر وارد کنید'),
                  //         ),
                  //         btnOkText: 'متوجه شدم',
                  //         btnOkOnPress: () {},
                  //       ).show();
                  //     } else if (typeId == 0) {
                  //       AwesomeDialog(
                  //         context: context,
                  //         body: const Center(
                  //           child: Text('یک تاج گل انتخاب کنید'),
                  //         ),
                  //         btnOkText: 'متوجه شدم',
                  //         btnOkOnPress: () {},
                  //       ).show();
                  //     } else if (tarhId == 0) {
                  //       AwesomeDialog(
                  //         context: context,
                  //         body: const Center(
                  //           child: Text('یک طرح انتخاب کنید'),
                  //         ),
                  //         btnOkText: 'متوجه شدم',
                  //         btnOkOnPress: () {},
                  //       ).show();
                  //     } else {
                  //       var respnose = typeModel!.data
                  //           .where((element) => element.id == typeId);
                  //       String title = respnose.first.title;

                  //       setState(() {
                  //         listOfNames.add(
                  //             ListOfNamesModel(textfildController.text, title));
                  //       });
                  //     }
                  //   }),
                  // )),
                  // const SliverToBoxAdapter(
                  //   child: Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 24),
                  //       child: Text('لیست نام ها:')),
                  // ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return index == listOfNames.length - 1
                              ? Padding(
                                  padding: EdgeInsets.only(bottom: 72),
                                  child: ListOfNamesItem(
                                    name: listOfNames[index].name,
                                    type: listOfNames[index].type,
                                    index: index,
                                  ),
                                )
                              : ListOfNamesItem(
                                  name: listOfNames[index].name,
                                  type: listOfNames[index].type,
                                  index: index,
                                );
                        },
                        childCount: listOfNames.length,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: _getNextLevelButton(context, state, widget.eventId)),
              )
            ],
          );
        } else {
          return ErrorBox(
            errorMessage: 'خطای ناشناخته',
            onTap: () {
              BlocProvider.of<FurtherInfoBloc>(context)
                  .add(GetFurtherInfoEvent());
            },
          );
        }
      }),
    );
  }

  Widget _getButton(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: blueDark,
        minimumSize: Size(
          140,
          40,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onPressed: onTap,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15),
        ),
        const SizedBox(
          width: 4,
        ),
        Icon(
          icon,
          size: 24,
        ),
      ]),
    );
  }

  SliverToBoxAdapter _getReservesNameList() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 8),
        child: Container(
          height: 190,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('از طرف'),
                    Text('نوع تاج گل'),
                    SizedBox(
                      width: 53,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getNextLevelButton(
      BuildContext context, FurtherInfoState state, int eventId) {
    if (state is LoadingCreatOrder) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: blueDark,
            minimumSize: Size(
              MediaQuery.of(context).size.width / 2.5,
              50,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {},
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'مرحله بعد',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(
              width: 4,
            ),
            const Icon(
              Icons.arrow_forward,
              size: 24,
            ),
          ]),
        ),
      );
    }
    if (state is FurtherInfoLoadedState) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: blueDark,
            minimumSize: Size(
              MediaQuery.of(context).size.width / 2.5,
              50,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            if (textfildController.text == '') {
              AwesomeDialog(
                context: context,
                body: const Center(
                  child: Text('یک نام معتبر وارد کنید'),
                ),
                btnOkText: 'متوجه شدم',
                btnOkOnPress: () {},
              ).show();
            } else if (typeId == 0) {
              AwesomeDialog(
                context: context,
                body: const Center(
                  child: Text('یک تاج گل انتخاب کنید'),
                ),
                btnOkText: 'متوجه شدم',
                btnOkOnPress: () {},
              ).show();
            } else if (tarhId == 0) {
              AwesomeDialog(
                context: context,
                body: const Center(
                  child: Text('یک طرح انتخاب کنید'),
                ),
                btnOkText: 'متوجه شدم',
                btnOkOnPress: () {},
              ).show();
            } else {
              var respnose =
                  typeModel!.data.where((element) => element.id == typeId);
              String title = respnose.first.title;

              // setState(() {
              //   listOfNames
              //       .add(ListOfNamesModel(textfildController.text, title));
              // });
              // BlocProvider.of<FurtherInfoBloc>(context).add(CreatOrderEvent(
              //     textfildController.text,
              //     eventId,
              //     wearthTypeSelectedItem,
              //     wearthTarhSelectedItem));

              BlocProvider.of<FurtherInfoBloc>(context).add(CreatOrderEvent(
                textfildController.text,
                eventId,
                typeId,
                tarhId,
              ));
            }
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'مرحله بعد',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(
              width: 4,
            ),
            const Icon(
              Icons.arrow_forward,
              size: 24,
            ),
          ]),
        ),
      );
    } else {
      return ErrorBox(
        errorMessage: 'خطا',
        onTap: () {},
      );
    }
  }

  SliverToBoxAdapter _getNameTextFildandTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'از طرف :',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          _getNameTextFild(context),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'انتخاب تاج گل :',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _getAppBar(BuildContext context) {
    return SliverAppBar(
      title: const Text('تکمیل اطلاعات'),
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
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Text('۲/۳'),
        ),
      ],
    );
  }

  Padding _getNameTextFild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: TextFormField(
        // focusNode: focusNode,
        controller: textfildController,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.person_outlined,
            color: Colors.grey,
          ),
          filled: true,
          fillColor: white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: blueDark),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: blueLight,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          hintText: '  نام و نام خانوادگی  ',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ),
    );
  }
}

class ListOfNamesItem extends StatefulWidget {
  ListOfNamesItem({
    super.key,
    required this.name,
    required this.type,
    required this.index,
  });
  String name;
  String type;
  int index;
  @override
  State<ListOfNamesItem> createState() => _ListOfNamesItemState();
}

class _ListOfNamesItemState extends State<ListOfNamesItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 40,
        color: grey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.name),
              Text(widget.type),
              SizedBox(
                width: 53,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      listOfNames.removeAt(widget.index);
                    });

                    BlocProvider.of<FurtherInfoBloc>(context)
                        .add(GetFurtherInfoEvent());
                  },
                  child: Text(
                    'حذف',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.red, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class getTypeGallery extends StatefulWidget {
  getTypeGallery({
    this.wearthTypeModel,
    Key? key,
  }) : super(key: key);
  WearthTypeModel? wearthTypeModel;

  @override
  State<getTypeGallery> createState() => _getTypeGalleryState();
}

class _getTypeGalleryState extends State<getTypeGallery> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, left: 32, top: 16, bottom: 16),
      child: Container(
        height: 284,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: SizedBox(
                      height: 200,
                      width: 280,
                      child: CachedNetworkImage(
                        imageUrl: widget
                            .wearthTypeModel!.data[wearthTypeSelectedItem].img,
                      )),
                ),
              ),
              if (widget.wearthTypeModel != null) ...{
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                      itemCount: widget.wearthTypeModel!.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                wearthTypeSelectedItem = index;
                              });
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width:
                                      wearthTypeSelectedItem == index ? 3 : 1,
                                  color: wearthTypeSelectedItem == index
                                      ? blueLight
                                      : grey,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 4),
                                  child: CachedNetworkImage(
                                      imageUrl: widget
                                          .wearthTypeModel!.data[index].img)),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Text('قیمت : '),
                    Text(
                      widget
                          .wearthTypeModel!.data[wearthTypeSelectedItem].amount
                          .toString()
                          .toPersianDigit(),
                    ),
                  ],
                )
              },
            ],
          ),
        ),
      ),
    );
  }
}

class GetTarhGallery extends StatefulWidget {
  GetTarhGallery({
    this.wearthTarheModel,
    Key? key,
  }) : super(key: key);
  WreathTarhModel? wearthTarheModel;

  @override
  State<GetTarhGallery> createState() => _GetTarhGalleryState();
}

class _GetTarhGalleryState extends State<GetTarhGallery> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, left: 32, top: 16, bottom: 16),
      child: Container(
        height: 284,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: SizedBox(
                      height: 200,
                      width: 280,
                      child: CachedNetworkImage(
                        imageUrl: widget
                            .wearthTarheModel!.data[wearthTarhSelectedItem].img,
                      )),
                ),
              ),
              if (widget.wearthTarheModel != null) ...{
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                      itemCount: widget.wearthTarheModel!.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                wearthTarhSelectedItem = index;
                              });
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width:
                                      wearthTarhSelectedItem == index ? 3 : 1,
                                  color: wearthTarhSelectedItem == index
                                      ? blueLight
                                      : grey,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 4),
                                  child: CachedNetworkImage(
                                      imageUrl: widget
                                          .wearthTarheModel!.data[index].img)),
                            ),
                          ),
                        );
                      }),
                )
              },
            ],
          ),
        ),
      ),
    );
  }
}
