import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/providers/themeprovider.dart';
import 'package:newsapp/theme.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    String selectedLanguage =
        context.locale.toString() == "en" ? "english" : "arabic";

    String selectedTheme =
        themeProvider.thememode == ThemeMode.dark ? "dark" : "light";

    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      height: double.infinity,
      decoration: BoxDecoration(
          color: MyThemeData.darkColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24.r),
              bottomRight: Radius.circular(24.r))),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 168.h,
            decoration: BoxDecoration(
                color: MyThemeData.lightColor,
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(24.r))),
            child: Text(
              "news_app".tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.home_outlined,
                  color: MyThemeData.lightColor,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Text(
                    "go_home".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: MyThemeData.lightColor),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Divider(
            thickness: 1,
            color: MyThemeData.lightColor,
            indent: 16.w,
            endIndent: 16.w,
          ),
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.format_paint_outlined,
                  color: MyThemeData.lightColor,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  "theme".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: MyThemeData.lightColor),
                )
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: MyThemeData.lightColor)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: MyThemeData.darkColor,
                  value: selectedTheme,
                  items: ["light", "dark"].map((String theme) {
                    return DropdownMenuItem<String>(
                      value: theme,
                      child: Text(
                        theme.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: MyThemeData.lightColor),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTheme = newValue!;
                      themeProvider.changeTheme();
                    });
                  },
                  icon: const Icon(Icons.arrow_drop_down,
                      color: MyThemeData.lightColor),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Divider(
            thickness: 1,
            color: MyThemeData.lightColor,
            indent: 16.w,
            endIndent: 16.w,
          ),
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.language,
                  color: MyThemeData.lightColor,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  "language".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: MyThemeData.lightColor),
                )
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: MyThemeData.lightColor)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: MyThemeData.darkColor,
                  value: selectedLanguage,
                  items: ["arabic", "english"].map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Container(
                        child: Text(
                          language.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: MyThemeData.lightColor),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLanguage = newValue!;
                      context.setLocale(
                          Locale(selectedLanguage == "english" ? "en" : "ar"));
                    });
                  },
                  icon: const Icon(Icons.arrow_drop_down,
                      size: 32, color: MyThemeData.lightColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
