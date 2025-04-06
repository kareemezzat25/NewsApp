import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/providers/themeprovider.dart';
import 'package:newsapp/widgets/categoryitem.dart';
import 'package:provider/provider.dart';

class CategoriesSection extends StatelessWidget {
  Function onCategoryClick;
  List<String> categories = [
    "general",
    "business",
    "sports",
    "health",
    "entertainment",
    "technology",
    "science",
  ];
  List<String> categoriesDark = [
    "general_dark",
    "business_dark",
    "sports_dark",
    "health_dark",
    "entertainment_dark",
    "technology_dark",
    "science_dark"
  ];
  CategoriesSection({required this.onCategoryClick, super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Column(
        children: [
          Text(
            "go_morning".tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: 16.h,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      onCategoryClick(categories[index]);
                    },
                    child: CategoryItem(
                      categoryImage: themeProvider.thememode == ThemeMode.dark
                          ? categoriesDark[index]
                          : categories[index],
                      isRight: index.isEven,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 16.h,
                  );
                },
                itemCount: categories.length),
          )
        ],
      ),
    );
  }
}
