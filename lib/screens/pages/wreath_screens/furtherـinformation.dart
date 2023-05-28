import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../constants/constants.dart';

class FurtherInformationScreen extends StatelessWidget {
  FurtherInformationScreen({super.key});
  List<String>? names;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _getAppBar(context),
          _getNameTextFildandTitle(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _getButton(context, 'انتخاب تاج گل', Icons.local_florist, () {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.scale,
                      dialogType: DialogType.noHeader,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      body: Column(
                        children: [
                          const Text(
                            'نوع تاج گل را انتخاب کنید',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          getGallery(),
                        ],
                      ),
                      title: 'This is Ignored',
                      desc: 'This is also Ignored',
                      btnOkOnPress: () {},
                    ).show();
                  }),
                  _getButton(context, 'انتخاب طرح', Icons.brush, () {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.scale,
                      dialogType: DialogType.noHeader,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      body: Column(
                        children: [
                          const Text(
                            'نوع تاج گل را انتخاب کنید',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          getGallery(),
                        ],
                      ),
                      title: 'This is Ignored',
                      desc: 'This is also Ignored',
                      btnOkOnPress: () {},
                    ).show();
                  }),
                ],
              ),
            ),
          ),

          // SliverToBoxAdapter(child: getGallery()),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: _getButton(context, 'افزودن', Icons.add, () {}),
          )),
          const SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text('لیست نام ها:')),
          ),
          _getReservesNameList(),
          _getNextLevelButton(context)
        ],
      ),
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
              SizedBox(
                height: 150,
                child: ListView.builder(
                  reverse: false,
                  itemCount: 5,
                  itemBuilder: (context, index) {
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
                              Text('از طرف'),
                              Text('نوع تاج گل'),
                              SizedBox(
                                width: 53,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'حذف',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                            color: Colors.red, fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _getNextLevelButton(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
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
              // side: BorderSide(
              //   width: 1,
              //   color: white,
              // ),
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
      ),
    );
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
      child: TextField(
        // focusNode: focusNode,

        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.person_outlined,
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
          hintText: '  نام و نام خانوادگی  ',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ),
    );
  }
}

class getGallery extends StatefulWidget {
  List<String> productImages = [
    'assets/images/item10.jpg',
    'assets/images/item11.jpg',
    'assets/images/item12.jpg',
    'assets/images/item13.jpg',
    'assets/images/item14.jpg',
  ];

  int selectedItem = 0;

  getGallery({
    Key? key,
  }) : super(key: key);

  @override
  State<getGallery> createState() => _getGalleryState();
}

class _getGalleryState extends State<getGallery> {
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
                    child: Image.asset(
                      widget.productImages[widget.selectedItem],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              if (widget.productImages.isNotEmpty) ...{
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                      itemCount: widget.productImages.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.selectedItem = index;
                              });
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: widget.selectedItem == index ? 3 : 1,
                                  color: widget.selectedItem == index
                                      ? blueLight
                                      : grey,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 4),
                                child: Image(
                                  image:
                                      AssetImage(widget.productImages[index]),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              }
            ],
          ),
        ),
      ),
    );
  }
}
