import 'package:flutter/material.dart';
import 'package:newsapp/apimanager.dart';
import 'package:newsapp/models/newsmodel.dart';
import 'package:newsapp/theme.dart';
import 'package:newsapp/widgets/newsItem.dart';

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
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Center(
                child: Text(
                  "SomeThing Went Wrong",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            );
          }
          var length = snapshot.data?.articles?.length ?? 0;
          if (length == 0) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: Text(
                  "There is no data.",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            );
          }
          return ListView.builder(
              itemBuilder: (context, index) {
                return NewsItem(article: snapshot.data!.articles![index]);
              },
              itemCount: snapshot.data?.articles?.length ?? 0);
        });
  }
}
