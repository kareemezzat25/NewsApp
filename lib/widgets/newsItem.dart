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
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
              color: themeProvider.thememode == ThemeMode.dark
                  ? MyThemeData.lightColor
                  : MyThemeData.darkColor)),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                article.urlToImage ??
                    "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fillustrations%2Ferror&psig=AOvVaw1BrHbJAZdM1uJTZ7t0RJYA&ust=1743868143136000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCJjc_p3dvowDFQAAAAAdAAAAABAE",
                width: 345.w,
                height: 220.h,
                fit: BoxFit.fill,
              ),
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
                Flexible(
                  child: Text(
                    "By : ${article.author}",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Text(getTimeAgo(article.publishedAt!))
              ],
            )
          ],
        ),
      ),
    );
  }

  String getTimeAgo(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return timeago.format(dateTime,
        locale: 'en'); // You can change locale if needed
  }
}
