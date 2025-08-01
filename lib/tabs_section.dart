import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/bloc/cubit.dart';
import 'package:newsapp/bloc/state.dart';
import 'package:newsapp/providers/themeprovider.dart';
import 'package:newsapp/repository/repo_remote_impl.dart';
import 'package:newsapp/theme.dart';
import 'package:newsapp/widgets/newsdata.dart';
import 'package:provider/provider.dart';

class TabsSection extends StatelessWidget {
  String category;
  Function onBackHome;
  TabsSection({required this.category, required this.onBackHome, super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return BlocProvider(
      create: (context) =>
          HomeCubit(repo: RepoRemoteImplimention())..getSources(category),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is GetSourcesLoadingState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  title: Center(
                    child: CircularProgressIndicator(
                      color: themeProvider.thememode == ThemeMode.dark
                          ? MyThemeData.lightColor
                          : MyThemeData.darkColor,
                    ),
                  ),
                );
              },
            );
          }
          if (state is GetSourcesErrorState) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      "Error",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.blue),
                    ),
                    content: Text(
                      state.messageError!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: MyThemeData.darkColor),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            onBackHome();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyThemeData.lightColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.r))),
                          child: Text(
                            "Go To Home",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.blue),
                          ))
                    ],
                  );
                });
          }
        },
        builder: (context, state) {
          var bloc = BlocProvider.of<HomeCubit>(context);
          var sources = bloc.sourceResponse?.sources ?? [];

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
              Expanded(
                  child: NewsData(
                onBackHome: onBackHome,
              ))
            ],
          );
        },
      ),
    );
  }
}
