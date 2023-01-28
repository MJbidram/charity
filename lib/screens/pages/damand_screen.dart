import 'package:charity/constants/constants.dart';
import 'package:charity/data/repository/damand_repository.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/damand_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../util/auth_manager.dart';

class DamandScreen extends StatefulWidget {
  const DamandScreen({super.key});

  @override
  State<DamandScreen> createState() => _DamandScreenState();
}

class _DamandScreenState extends State<DamandScreen> {
  final IDamandRepository repository = locator.get();
  var response;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(slivers: [
        appBar(context),
        body(),
      ]),
    ));
  }

  SliverToBoxAdapter body(List<DamandTypeModel> item) {
    return SliverToBoxAdapter(
      child: Form(
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
          items: item
              .map((item) => DropdownMenuItem<String>(
                    value: item.id.toString(),
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          validator: (value) {},
          onChanged: (value) {},
          onSaved: (value) {},
        ),
      ),
    );
  }

  SliverAppBar appBar(BuildContext context) {
    return SliverAppBar(
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
                  bottom:
                      Radius.elliptical(MediaQuery.of(context).size.width, 150),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
