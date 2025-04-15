import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/categories_section.dart';
import 'package:newsapp/tabs_section.dart';
import 'package:newsapp/widgets/app_drawer.dart';

class HomeView extends StatefulWidget {
  static const String routeName = "HomeView";
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(
          onBack: onBackDrawer,
        ),
        appBar: AppBar(
          title: Text(
            selectedCategory?.tr() ?? "home".tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: [
            Padding(
              padding: context.locale.toString() == "en"
                  ? EdgeInsets.only(right: 8.w)
                  : EdgeInsets.only(left: 8.w),
              child: const Icon(Icons.search),
            )
          ],
        ),
        body: selectedCategory == null
            ? CategoriesSection(
                onCategoryClick: onCategoryClicked,
              )
            : TabsSection(
                category: selectedCategory!,
                onBackHome: onBackDrawer,
              ));
  }

  onCategoryClicked(String category) {
    selectedCategory = category;
    setState(() {});
  }

  onBackDrawer() {
    selectedCategory = null;
    setState(() {
      Navigator.pop(context);
    });
  }
}
