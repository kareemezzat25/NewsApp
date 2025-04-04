import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/apimanager.dart';
import 'package:newsapp/models/sourcemodel.dart';
import 'package:newsapp/providers/themeprovider.dart';
import 'package:newsapp/theme.dart';
import 'package:newsapp/widgets/app_drawer.dart';
import 'package:newsapp/widgets/newsdata.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  static const String routeName = "HomeView";

  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text(
            "general".tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: [
            Padding(
              padding: context.locale.toString() == "en"
                  ? EdgeInsets.only(right: 8.w)
                  : EdgeInsets.only(left: 8.w),
              child: const Icon(Icons.search),
            )
          ],
        ),
        body: FutureBuilder<SourceResponse>(
          future: ApiManager.getSources(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            if (snapshot.hasError) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Center(child: Text("SomeThing went Wrong")),
              );
            }
            var data = snapshot.data?.sources ?? [];
            return Column(
              children: [
                DefaultTabController(
                    length: data.length,
                    initialIndex: selectedIndex,
                    child: TabBar(
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        indicatorColor: MyThemeData.darkColor,
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                        unselectedLabelStyle:
                            Theme.of(context).textTheme.titleSmall,
                        onTap: (value) {
                          selectedIndex = value;
                          setState(() {});
                        },
                        tabs: data
                            .map((source) => Tab(
                                  text: source.name,
                                ))
                            .toList())),
                Expanded(
                    child: NewsData(sourceId: data[selectedIndex].id ?? ""))
              ],
            );
          },
        ));
  }
}
