import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc/cubit.dart';
import 'package:newsapp/bloc/state.dart';
import 'package:newsapp/theme.dart';
import 'package:newsapp/widgets/newsdata.dart';

class TabsSection extends StatelessWidget {
  String category;
  TabsSection({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getSources(category),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<HomeCubit>(context);
          var sources = bloc.sourceResponse?.sources ?? [];
          if (state is GetSourcesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: MyThemeData.darkColor,
              ),
            );
          } else if (state is GetSourcesErrorState) {
            return Center(
              child: Text(
                "SomeThing Went Wrong",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }
          return Column(
            children: [
              DefaultTabController(
                  length: sources?.length ?? 0,
                  initialIndex: bloc.selectedIndex,
                  child: TabBar(
                      isScrollable: true,
                      dividerColor: Colors.transparent,
                      indicatorColor: MyThemeData.darkColor,
                      labelStyle: Theme.of(context).textTheme.titleSmall,
                      unselectedLabelStyle:
                          Theme.of(context).textTheme.titleSmall,
                      onTap: (value) {
                        bloc.changeSelectedIndexTab(value);
                      },
                      tabs: sources
                          .map((source) => Tab(
                                text: source.name,
                              ))
                          .toList())),
              Expanded(child: NewsData())
            ],
          );
        },
      ),
    );
  }
}
