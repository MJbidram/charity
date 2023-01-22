import 'package:charity/bloc/factors_bloc/factors_bloc.dart';
import 'package:charity/bloc/factors_bloc/factors_event.dart';
import 'package:charity/bloc/factors_bloc/factors_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/data/repository/factors_repository.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/factors_model.dart';
import 'package:charity/util/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FactorsScreen extends StatefulWidget {
  const FactorsScreen({super.key});

  @override
  State<FactorsScreen> createState() => _FactorsScreenState();
}

class _FactorsScreenState extends State<FactorsScreen> {
  @override
  void initState() {
    BlocProvider.of<FactorsBloc>(context)
        .add(FactorRequestListEvent(AuthManager.authChangeNotifire.value));
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
            BlocBuilder<FactorsBloc, FactorsState>(
              builder: (context, state) {
                if (state is FactorsLoadingState) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is FactorsLoadedState) {
                  return state.response.fold((l) {
                    return Text(l);
                  }, (r) {
                    return FactoersList(
                      factorsModel: r,
                    );
                  });
                }
                return const SliverToBoxAdapter(child: Text('error'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FactoersList extends StatelessWidget {
  List<FactorsModle> factorsModel;
  FactoersList({
    Key? key,
    required this.factorsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            height: 128.0,
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
                      'مبلغ',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const Spacer(),
                    Text(
                      factorsModel[index].amunt.toString(),
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
                      'بابت',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const Spacer(),
                    Text(
                      factorsModel[index].title.toString(),
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
                      'شماره پیگیری',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const Spacer(),
                    Text(
                      factorsModel[index].sabtId.toString(),
                      style: Theme.of(context).textTheme.headline2,
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
      }, childCount: factorsModel.length),
    );
  }
}
