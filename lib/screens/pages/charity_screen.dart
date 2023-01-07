import 'package:charity/constants/constants.dart';
import 'package:charity/data/repository/charity_repository.dart';
import 'package:charity/data/repository/payment_repository.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/charity_model.dart';
import 'package:charity/models/pay_link_model.dart';
import 'package:charity/util/auth_manager.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';

String? selectedValue;
TextEditingController amount = TextEditingController();

class CharityPage extends StatefulWidget {
  CharityPage({super.key, required this.items});
  List<CharityModel>? items;
  @override
  State<CharityPage> createState() => _CharityPageState();
}

class _CharityPageState extends State<CharityPage> {
  FocusNode myFocusNode1 = FocusNode();
  List<CharityModel>? itemsCharity;

  String firstType = '';

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    myFocusNode1.addListener(() {
      setState(() {});
    });
    itemsCharity = widget.items;
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
          const SizedBox(
            height: 16,
          ),
          _getDropDownFildFirest(context),
          const SizedBox(
            height: 32,
          ),
          Text(
            'انتخاب نوع جزئی تر:',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 16,
          ),
          _getDropDownFildsecand(context),
          const SizedBox(
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
              onPressed: () async {
                PayLinkModel? payLinkModel;
                String _amount = amount.text.toString();
                String? token = await AuthManager.readauth();
                IpaymentRepository paymentRepository = locator.get();
                var either = await paymentRepository.getPaymentData(
                    '1', _amount, token!);
                either.fold((l) => print(l), (r) async {
                  payLinkModel = r;
                  var either2 =
                      await paymentRepository.launchUrlForPayment(r.url);
                  either2.fold((l) => print(l), (r) => print(r));
                });
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'انتقال به صفحه پرداخت',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(
                  width: 4,
                ),
                const Icon(
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
        controller: amount,
        focusNode: myFocusNode1,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: blueDark,
          fontFamily: 'GM',
          fontSize: 16,
        ),
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: blueDark,
                width: 3,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
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
    myFocusNode1.dispose();

    super.dispose();
  }

  DropdownButtonFormField2 _getDropDownFildFirest(BuildContext context) {
    return DropdownButtonFormField2(
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
      items: itemsCharity
          ?.map((item) => DropdownMenuItem<String>(
                value: item.id!.toString(),
                child: Text(
                  item.title,
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
        setState(() {
          firstType = value;
          // _getSecandTyps(firstType);
        });
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
    );
  }

  DropdownButtonFormField2 _getDropDownFildsecand(BuildContext context) {
    return DropdownButtonFormField2(
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
      items: charityModelSecand
              ?.map((item) => DropdownMenuItem<String>(
                    value: item.sub!.toString(),
                    child: Text(
                      item.title!,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList() ??
          [],
      validator: (value) {
        if (value == null) {
          return 'Please select gender.';
        }
      },
      onChanged: (value) {
        print('${itemsCharity![0].title}');
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
    );
  }

  String? secandType;
  List<CharityModelSecand>? charityModelSecand;
  void _getSecandTyps(String firstType) async {
    var eithr = await CharityRepository().getSecandTyp(firstType);
    eithr.fold(
      (l) => print(l),
      (r) {
        print('charity model is :: ${r}');
        setState(() {
          charityModelSecand = r;
        });
      },
    );
  }
}
