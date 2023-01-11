import 'package:charity/constants/constants.dart';
import 'package:charity/data/repository/charity_repository.dart';
import 'package:charity/data/repository/payment_repository.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/charity_model.dart';
import 'package:charity/models/pay_link_model.dart';
import 'package:charity/screens/widget/category_amunt_used.dart';
import 'package:charity/util/auth_manager.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../widget/category_items.dart';

String? selectedValue;
TextEditingController amount = TextEditingController();

class CharityPage extends StatefulWidget {
  CharityPage({super.key, required this.items});
  List<CharityModelFirst>? items;
  @override
  State<CharityPage> createState() => _CharityPageState();
}

class _CharityPageState extends State<CharityPage> {
  FocusNode _myFocusNode1 = FocusNode();
  List<CharityModelFirst>? itemsCharity;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String firstType = '';
  String secandType = '';
  int? needSecandType;
  String? idType;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _myFocusNode1.addListener(() {
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
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
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
                      child: const Image(
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
    var _box = Hive.box('information');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      child: Form(
        key: _formKey,
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
            const SizedBox(
              height: 32,
            ),
            const Text('تعیین مبلغ'),
            const SizedBox(
              height: 16,
            ),
            amountTextFild(),
            const SizedBox(
              width: double.infinity,
              height: 16,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Wrap(
                spacing: 10,
                runSpacing: 15,
                alignment: WrapAlignment.center,
                children: [
                  AmountUsed(
                    amountText: '۵,۰۰۰',
                    amountValue: '5000',
                    onTap: () {
                      setState(() {
                        amount.text = '5000';
                      });
                    },
                  ),
                  AmountUsed(
                    amountText: '۱۰,۰۰۰',
                    amountValue: '10000',
                    onTap: () {
                      setState(() {
                        amount.text = '10000';
                      });
                    },
                  ),
                  AmountUsed(
                    amountText: '۲۰,۰۰۰',
                    amountValue: '20000',
                    onTap: () {
                      setState(() {
                        amount.text = '20000';
                      });
                    },
                  ),
                  AmountUsed(
                    amountText: '۵۰,۰۰۰',
                    amountValue: '50000',
                    onTap: () {
                      setState(() {
                        amount.text = '50000';
                      });
                    },
                  ),
                  AmountUsed(
                    amountText: '۱۰۰,۰۰۰',
                    amountValue: '100000',
                    onTap: () {
                      setState(() {
                        amount.text = '100000';
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
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
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blueDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  PayLinkModel? payLinkModel;
                  String _amount = amount.text.toString();
                  _amount = removeZero(_amount);
                  String? token = await AuthManager.readauth();
                  IpaymentRepository paymentRepository = locator.get();
                  print(idType);
                  var either = await paymentRepository.getPaymentData(
                      idType!, _amount, token!);
                  either.fold((l) => print(l), (r) async {
                    payLinkModel = r;
                    await _box.put('factorId', r.faktoorId);
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
      ),
    );
  }

  Widget amountTextFild() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        validator: (value) {
          if (value != null) {
            value = removeZero(value);
          }
          if (value!.length >= 4 &&
              !value.contains('.') &&
              !value.contains('-')) {
            return null;
          } else if (value.isNotEmpty && value.length < 4) {
            return 'مقدار وارد شده کم تر از حد مجاز است!';
          } else if (value.contains('.') || value.contains('-')) {
            return 'مبلغ مجاز نیست';
          } else {
            return 'ابتدا مبلغ را وارد کنید';
          }
        },
        controller: amount,
        focusNode: _myFocusNode1,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: blueDark,
          fontFamily: 'GM',
          fontSize: 16,
        ),
        onChanged: (value) {},
        decoration: InputDecoration(
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 3,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
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
            labelText: '  مبلغ (تومان)  ',
            labelStyle: TextStyle(
              fontFamily: 'GM',
              color: _myFocusNode1.hasFocus ? blueDark : Colors.grey,
              fontSize: 18,
            )),
      ),
    );
  }

  Widget _getDropDownFildFirest(BuildContext context) {
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
          return 'لطفا نوع صدقه خود را انتخاب کنید';
        }
      },
      onChanged: (value) {
        needSecandType =
            itemsCharity![int.parse(value!) - 1].optionalSubSelect!;
        print('needSecandType' + needSecandType.toString());
        setState(() {
          _getSecandTyps(value);
          if (needSecandType == 1) {
            idType = value.toString();
          }
        });
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
    );
  }

  Widget _getDropDownFildsecand(BuildContext context) {
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
                    value: item.id!.toString(),
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
        if (value == null && needSecandType == 0) {
          return 'لطفا نوع جزئی تر را انتخاب کنید';
        }
      },
      onChanged: (value) {
        idType = value.toString();
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
    );
  }

  List<CharityModelSecand>? charityModelSecand;
  void _getSecandTyps(String firstType) async {
    var eithr = await CharityRepository().getSecandTyp(firstType);
    eithr.fold(
      (l) {
        print(l);
      },
      (r) {
        print('charity model is :: ${r}');
        setState(() {
          charityModelSecand = r;
        });
      },
    );
  }

  @override
  void dispose() {
    _myFocusNode1.dispose();

    super.dispose();
  }
}

String removeZero(String num) {
  for (var i = 0; i < num.length; i++) {
    if (num[i] != '0') {
      String res = num.substring(i);
      print(res);
      return res;
    }
  }

  return '0';
}
