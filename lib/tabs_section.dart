import 'package:flutter/material.dart';
import 'package:newsapp/apimanager.dart';
import 'package:newsapp/models/sourcemodel.dart';
import 'package:newsapp/theme.dart';
import 'package:newsapp/widgets/newsdata.dart';

class TabsSection extends StatefulWidget {
  String category;
  TabsSection({required this.category, super.key});

  @override
  State<TabsSection> createState() => _TabsSectionState();
}

class _TabsSectionState extends State<TabsSection> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse>(
      future: ApiManager.getSources(widget.category),
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
            Expanded(child: NewsData(sourceId: data[selectedIndex].id ?? ""))
          ],
        );
      },
    );
  }
}
