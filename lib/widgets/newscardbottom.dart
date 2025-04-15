import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/categories_section.dart';
import 'package:newsapp/models/newsmodel.dart';
import 'package:newsapp/providers/themeprovider.dart';
import 'package:newsapp/theme.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:url_launcher/url_launcher.dart';

class NewsCardBottomSheet extends StatelessWidget {
  Articles? article;
  NewsCardBottomSheet({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                article?.urlToImage ?? "",
                width: 345.w,
                height: 220.h,
                fit: BoxFit.fill,
                errorBuilder: (context, error, StackTrace) {
                  return Container(
                    width: 345.w,
                    height: 220.h,
                    color: Colors.grey[350],
                    child: const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Directionality(
              textDirection: ui.TextDirection.ltr,
              child: Text(
                article?.title ?? "No Title",
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            ElevatedButton(
                onPressed: () async {
                  final url = article?.url ??
                      "https://www.abc.net.au/news/this-page-does-not-exist-404";
                  final Uri uri = Uri.parse(url);

                  try {
                    if (!await launchUrl(uri,
                        mode: LaunchMode.externalApplication)) {
                    } else {
                      Navigator.pop(context);
                      throw 'Could not launch $url';
                    }
                  } catch (e) {
                    print('Error launching URL: $e');
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          'Could not open the article',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: MyThemeData.lightColor),
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(345.w, 56.h),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r)),
                    backgroundColor: themeProvider.thememode == ThemeMode.dark
                        ? MyThemeData.darkColor
                        : MyThemeData.lightColor),
                child: Text(
                  "view_article".tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ))
          ],
        ),
      ),
    );
  }
}
