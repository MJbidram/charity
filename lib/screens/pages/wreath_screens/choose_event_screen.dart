import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:charity/bloc/further_information_bloc/further_info_bloc.dart';
import 'package:charity/bloc/maresemat_bloc/marasemat_bloc.dart';
import 'package:charity/bloc/maresemat_bloc/marasemat_event.dart';
import 'package:charity/bloc/maresemat_bloc/marasemat_state.dart';
import 'package:charity/models/marasemat.dart';
import 'package:charity/screens/pages/wreath_screens/further%D9%80information.dart';
import 'package:charity/screens/widget/error_box.dart';
import 'package:charity/screens/widget/spin_kit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../bloc/details_of_sliders/details_bloc.dart';
import '../../../constants/constants.dart';

String filter = '';
TextEditingController textcontroller = TextEditingController(text: filter);

class ChooseEventScreen extends StatefulWidget {
  ChooseEventScreen({super.key});

  @override
  State<ChooseEventScreen> createState() => _ChooseEventScreenState();
}

class _ChooseEventScreenState extends State<ChooseEventScreen> {
  int? _itemSelectedIndex;
  int selectedId = 0;
  List<MarasematModel> marasemsearch = [];
  List<MarasematModel> marasemat = [];

  final List<String> month = [
    'همه',
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];

  final List<String> typeEvent = [
    'همه',
    'هفته',
    'چهلم',
    'سال',
  ];
  @override
  void initState() {
    BlocProvider.of<MarasematBloc>(context).add(GetMarasematEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _getAppBar(context),
          SliverToBoxAdapter(
            child: _getSearchBox(context, marasemat),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 8,
                right: 24,
                left: 24,
              ),
              child: Text('فیلتر :'),
            ),
          ),
          SliverToBoxAdapter(
            child: _getFilterBoxes(),
          ),
          const SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.only(top: 16, right: 24),
                child: Text('لیست مراسمات')),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<MarasematBloc, MarasematState>(
                builder: (context, state) {
              if (state is LoadingMarasemState) {
                return const Center(
                  child: MySpinKit(),
                );
              }
              if (state is MarasematLoadedState) {
                return state.response.fold((l) {
                  return Center(
                    child: ErrorBox(
                      errorMessage: l,
                      onTap: () {},
                    ),
                  );
                }, (r) {
                  if (filter.isEmpty) {
                    marasemat = r;
                  } else {
                    marasemsearch = r.where((element) {
                      return element.marhoomName
                          .toLowerCase()
                          .contains(filter.toLowerCase());
                    }).toList();
                    marasemat = marasemsearch;
                  }
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // CustomScrollView(
                      //   slivers: [
                      // _getAppBar(context),
                      // _getTitle(context),
                      // SliverToBoxAdapter(
                      //   child: _getSearchBox(context, marasemat),
                      // ),
                      // const SliverToBoxAdapter(
                      //   child: Padding(
                      //     padding: EdgeInsets.only(
                      //       bottom: 8,
                      //       right: 24,
                      //       left: 24,
                      //     ),
                      //     child: Text('فیلتر :'),
                      //   ),
                      // ),
                      // SliverToBoxAdapter(
                      //   child: _getFilterBoxes(),
                      // ),
                      // const SliverToBoxAdapter(
                      //   child: Padding(
                      //       padding: EdgeInsets.only(top: 16, right: 24),
                      //       child: Text('لیست مراسمات')),
                      // ),
                      // SliverPadding(
                      //   padding: const EdgeInsets.only(
                      //     bottom: 86,
                      //   ),
                      //   sliver: getListOfEvent(marasemat),
                      // ),

                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 0,
                        ),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height / 1.7,
                            child: getListOfEvent(marasemat)),
                      ),
                      //   ],
                      // ),
                      Positioned(
                          // alignment: AlignmentDirectional.topCenter,
                          bottom: 8,
                          child: Container(
                            height: 70,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              topLeft: Radius.circular(16),
                            )),
                            child: _getButtons(context),
                          ))
                    ],
                  );
                });
              } else {
                return Center(
                  child: ErrorBox(
                    errorMessage: 'خطا',
                    onTap: () {},
                  ),
                );
              }
            }),
          )
        ],
      ),
    );
  }

  Widget getListOfEvent(List<MarasematModel> model) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return index == model.length - 1
            ? Padding(
                padding: const EdgeInsets.only(bottom: 64),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _itemSelectedIndex = index;
                        selectedId = model[index].id;
                      });
                    },
                    child: _getEventList(context, index, model[index])),
              )
            : GestureDetector(
                onTap: () {
                  setState(() {
                    _itemSelectedIndex = index;
                    selectedId = model[index].id;
                  });
                },
                child: _getEventList(context, index, model[index]));
      },
      itemCount: model.length,
    );
  }

  Padding _getButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 12),
      child: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blueDark,
                  minimumSize: Size(
                    MediaQuery.of(context).size.width / 2.5,
                    50,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    // side: BorderSide(
                    //   width: 1,
                    //   color: white,
                    // ),
                  ),
                ),
                onPressed: () {
                  if (selectedId == 0) {
                    AwesomeDialog(
                      context: context,
                      body: const Center(
                        child: Text('لطفا یک مراسم را انتخاب کنید'),
                      ),
                      btnOkText: 'متوجه شدم',
                      btnOkOnPress: () {},
                    ).show();
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => FurtherInfoBloc(),
                        child: FurtherInformationScreen(selectedId),
                      ),
                    ));
                  }
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: blueLight,
              //     minimumSize: Size(
              //       MediaQuery.of(context).size.width / 2.5,
              //       50,
              //     ),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(16),
              //       // side: BorderSide(
              //       //   width: 1,
              //       //   color: white,
              //       // ),
              //     ),
              //   ),
              //   onPressed: () {},
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         'افزودن مراسم',
              //         style: Theme.of(context).textTheme.headline3,
              //       ),
              //       const SizedBox(
              //         width: 4,
              //       ),
              //       const Icon(
              //         Icons.add,
              //         size: 24,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getEventList(
      BuildContext context, int index, MarasematModel marasem) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 0, right: 24, left: 24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: 170.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            width: _itemSelectedIndex == index ? 3 : 1,
            color: _itemSelectedIndex == index ? Colors.blueAccent : blueDark,
          ),
          gradient: _itemSelectedIndex == index ? blueGradient : null,
          color: const Color.fromARGB(255, 228, 230, 232),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(16),
          // margin: const EdgeInsets.all(1),
          decoration: _itemSelectedIndex == index
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(width: 2, color: white),
                )
              : const BoxDecoration(),
          child: Column(children: [
            Row(
              children: [
                Text(
                  'مراسم',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: _itemSelectedIndex == index ? white : black),
                ),
                const Spacer(),
                Text(
                  marasem.marhoomName,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: _itemSelectedIndex == index ? white : black),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  'تاریخ',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: _itemSelectedIndex == index ? white : black),
                ),
                const Spacer(),
                Text(
                  marasem.date.toPersianDate(),
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: _itemSelectedIndex == index ? white : black),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  'مکان',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: _itemSelectedIndex == index ? white : black),
                ),
                const Spacer(),
                Text(
                  marasem.location,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: _itemSelectedIndex == index ? white : black),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  'نوع',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: _itemSelectedIndex == index ? white : black),
                ),
                const Spacer(),
                Text(
                  marasem.marasemType ?? 'مراسم',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: _itemSelectedIndex == index ? white : black),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
          ]),
        ),
      ),
    );
  }

  Padding _getFilterBoxes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          FilterDropDown(items: month, hint: ' زمان مراسم'),
          const Spacer(),
          FilterDropDown(items: typeEvent, hint: 'نوع مراسم'),
        ],
      ),
    );
  }

  SliverAppBar _getAppBar(BuildContext context) {
    return SliverAppBar(
      title: Text('انتخاب مراسم'),
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
          child: Text('۱/۳'),
        ),
      ],
    );
  }

  SliverPadding _getTitle(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Text(
            'انتخاب مراسم',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
    );
  }

  Padding _getSearchBox(BuildContext context, List<MarasematModel> orMarasem) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: TextField(
        // focusNode: focusNode,
        controller: textcontroller,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          // suffixIcon: Icon(
          //   Icons.filter_alt_sharp,
          //   color: Colors.grey,
          // ),
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
          hintText: '  جستجوی مراسمات  ',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        onChanged: (value) {
          filter = value;
          BlocProvider.of<MarasematBloc>(context).add(GetMarasematEvent());
        },
      ),
    );
  }
}

class FilterDropDown extends StatelessWidget {
  const FilterDropDown({
    super.key,
    required this.items,
    required this.hint,
  });
  final String hint;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: DropdownButtonFormField2(
        decoration: InputDecoration(
          // label: Text('data'),

          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        isExpanded: true,
        dropdownWidth: MediaQuery.of(context).size.width / 2.5,
        // buttonWidth: 200,
        hint: Text(
          hint,
          style: TextStyle(fontSize: 14),
        ),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        dropdownMaxHeight: 250,

        iconSize: 30,
        buttonHeight: 40,
        buttonPadding: const EdgeInsets.only(left: 12, right: 12),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        onChanged: (value) {},
        onSaved: (value) {},
      ),
    );
  }
}
