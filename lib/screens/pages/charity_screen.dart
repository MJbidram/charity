import 'dart:ui';

import 'package:charity/constants/constants.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';

final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
  'Item5',
  'Item6',
  'Item7',
  'Item8',
  'Item1',
  'Item2',
  'Item3',
  'Item4',
  'Item5',
  'Item6',
  'Item7',
  'Item8',
];
String? selectedValue;

class CharityPage extends StatefulWidget {
  const CharityPage({super.key});

  @override
  State<CharityPage> createState() => _CharityPageState();
}

class _CharityPageState extends State<CharityPage> {
  FocusNode myFocusNode1 = FocusNode();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    myFocusNode1.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: grey,
        //app bar
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(250),
          child: AppBar(
            elevation: 0,
            toolbarHeight: 60,
            title: Text(
              shortName,
              style: Theme.of(context).textTheme.headline1,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.notifications,
                  size: 32,
                ),
              ),
            ],
            backgroundColor: grey,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: blueGradient,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 170),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: blueGradient,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 170),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 170),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 170),
                      ),
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/item15.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // body:

        //  NestedScrollView(
        //   headerSliverBuilder: (context, innerBoxIsScrolled) {
        //     return [
        //       // SliverAppBar(
        //       //   expandedHeight: 200,

        //       // )
        //     ];
        //   },
        body: SingleChildScrollView(child: _getCharityPageBody(context)),
        // ),
      ),
    );
  }

  Widget _getCharityPageBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: Text('پرداخت و نیکو کاری',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'VB',
                    fontSize: 18,
                    color: blueDark,
                  )),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Text('تعیین مبلغ'),
          SizedBox(
            height: 16,
          ),
          textfild1(),
          SizedBox(
            width: double.infinity,
            height: 16,
          ),
          Text(
            'نوع و موارد مصرف:',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 16,
          ),
          _getDropDownFild(context),
          SizedBox(
            height: 32,
          ),
          Text(
            'انتخاب نوع جزئی تر:',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 16,
          ),
          _getDropDownFild(context),
          SizedBox(
            height: 32,
          ),
          Container(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: blueDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {},
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'انتقال به صفحه پرداخت',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.payment,
                  size: 24,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget textfild1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: TextField(
        focusNode: myFocusNode1,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: blueDark,
          fontFamily: 'GM',
          fontSize: 16,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: blueDark,
                width: 3,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            labelText: '  مبلغ  ',
            labelStyle: TextStyle(
              fontFamily: 'GM',
              color: myFocusNode1.hasFocus ? blueDark : Colors.grey,
              fontSize: 18,
            )),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myFocusNode1.dispose();

    super.dispose();
  }

  Widget _getDropDownFild(BuildContext context) {
    return Container(
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
        hint: const Text(
          'انتخاب',
          style: TextStyle(fontSize: 14),
        ),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        dropdownMaxHeight: 200,
        iconSize: 30,
        buttonHeight: 50,
        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
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
        validator: (value) {
          if (value == null) {
            return 'Please select gender.';
          }
        },
        onChanged: (value) {
          //Do something when changing the item if you want.
        },
        onSaved: (value) {
          selectedValue = value.toString();
        },
      ),
    );
  }
}
