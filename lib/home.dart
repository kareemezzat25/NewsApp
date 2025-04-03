import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/apimanager.dart';
import 'package:newsapp/models/newsmodel.dart';
import 'package:newsapp/models/sourcemodel.dart';
import 'package:newsapp/theme.dart';
import 'package:newsapp/widgets/newsdata.dart';

class HomeView extends StatelessWidget {
  static const String routeName = "HomeView";
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text(
            "General",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: const [Icon(Icons.search)],
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
              return const Center(child: Text("SomeThing went Wrong"));
            }
            var data = snapshot.data?.sources ?? [];
            return Column(
              children: [
                DefaultTabController(
                    length: data.length,
                    child: TabBar(
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        indicatorColor: MyThemeData.darkColor,
                        labelColor: MyThemeData.darkColor,
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                        tabs: data
                            .map((source) => Tab(
                                  text: source.name,
                                ))
                            .toList())),
                SizedBox(
                  height: 16.h,
                ),
                Expanded(child: NewsData(sourceId: data[0].name ?? "the-verge"))
              ],
            );
          },
        ));
  }
}
