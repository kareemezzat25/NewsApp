import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/apimanager.dart';
import 'package:newsapp/models/newsmodel.dart';
import 'package:newsapp/theme.dart';

class NewsData extends StatelessWidget {
  String sourceId;
  NewsData({super.key, required this.sourceId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponse>(
        future: ApiManager.getNews(sourceId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: MyThemeData.darkColor,
              ),
            );
          }
          if (snapshot.hasError) {
            return Text(
              "SomeThing Went Wrong",
              style: Theme.of(context).textTheme.titleSmall,
            );
          }
          var length = snapshot.data?.articles?.length ?? 0;
          if (length == 0) {
            return Text(
              "There is No data.",
              style: Theme.of(context).textTheme.titleSmall,
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                return Text(snapshot.data?.articles?[index].content ?? "");
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 20.h,
                );
              },
              itemCount: snapshot.data?.articles?.length ?? 0);
        });
  }
}
