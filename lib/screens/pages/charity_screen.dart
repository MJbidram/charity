import 'dart:ui';

import 'package:charity/constants/constants.dart';
import 'package:charity/screens/widget/botom_sheet_comments.dart';

import 'package:flutter/material.dart';

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
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 175,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 16.0),
              child: Text(
                'خیریه امام علی (ع) شهر گرگاب',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ],
          leading: Icon(
            Icons.notifications,
            size: 32,
          ),
          backgroundColor: grey,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Container(
              decoration: BoxDecoration(
                gradient: blueGradient,
                borderRadius: BorderRadius.vertical(
                  bottom:
                      Radius.elliptical(MediaQuery.of(context).size.width, 170),
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
          Wrap(
            spacing: 8,
            runSpacing: 16,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text('صدقه'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text('متفرقه'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text('امور خیر'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text('پروژه های عمرانی'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text('کمک های خاص و شرعی'),
                ),
              ),
            ],
          ),
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 16,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text('صدقه'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text('متفرقه'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text('امور خیر'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text('پروژه های عمرانی'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text('کمک های خاص و شرعی'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text('صدقه'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text('متفرقه'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text('امور خیر'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text('پروژه های عمرانی'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text('کمک های خاص و شرعی'),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
              onPressed: () {
                _getBottomSheetNavigation(context);
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'تعیین مبلغ و پرداخت',
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

  Future<dynamic> _getBottomSheetNavigation(BuildContext context) {
    return showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.2,
            maxChildSize: 0.3,
            builder: (context, scrollController) {
              return _bottomSheetCharity(scrollController);
            },
          ),
        );
      },
    );
  }

  Widget _bottomSheetCharity(ScrollController controller) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(36),
        topRight: Radius.circular(36),
      ),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(102, 204, 204, 204),
              Color.fromARGB(102, 143, 143, 143),
            ])),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CustomScrollView(
                  controller: controller,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 10, bottom: 22, right: 125, left: 125),
                        height: 5,
                        width: 67,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: white),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text('تعیین مبلغ و پرداخت'),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      sliver: SliverToBoxAdapter(
                        child: textfild1(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blueDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'پرداخت',
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
                    )
                  ],
                )),
          ),
        ),
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
              borderSide: BorderSide(width: 3, color: grey),
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
}
