import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/models/newsmodel.dart';
import 'package:newsapp/providers/themeprovider.dart';
import 'package:newsapp/theme.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  Articles article;
  NewsItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
              color: themeProvider.thememode == ThemeMode.dark
                  ? MyThemeData.lightColor
                  : MyThemeData.darkColor)),
      child: Column(
        children: [
          Image.network(
            article.urlToImage!,
            width: 345.w,
            height: 220.h,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            article.title!,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "By : ${article.author}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(getTimeAgo(article.publishedAt!))
            ],
          )
        ],
      ),
    );
  }

  String getTimeAgo(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return timeago.format(dateTime,
        locale: 'en'); // You can change locale if needed
  }
}
