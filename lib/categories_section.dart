import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/theme.dart';
import 'package:newsapp/widgets/categoryitem.dart';

class CategoriesSection extends StatelessWidget {
  List<String> categories = [
    "general",
    "business",
    "sports",
    "health",
    "entertainment",
    "technology",
    "science",
  ];
  CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                  return CategoryItem(
                    categoryImage: categories[index],
                    isRight: index.isEven,
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
