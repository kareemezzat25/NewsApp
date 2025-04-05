import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/apimanager.dart';
import 'package:newsapp/categories_section.dart';
import 'package:newsapp/models/sourcemodel.dart';
import 'package:newsapp/providers/themeprovider.dart';
import 'package:newsapp/tabs_section.dart';
import 'package:newsapp/theme.dart';
import 'package:newsapp/widgets/app_drawer.dart';
import 'package:newsapp/widgets/newsdata.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  static const String routeName = "HomeView";

  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text(
            "general".tr(),
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
        body: CategoriesSection());
  }
}
