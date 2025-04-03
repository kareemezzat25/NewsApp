import 'package:flutter/material.dart';
import 'package:newsapp/home.dart';
import 'package:newsapp/providers/themeprovider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: NewsApp()));
}

class NewsApp extends StatelessWidget {
  NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: MyThemeData.lightTheme,
            darkTheme: MyThemeData.darkTheme,
            themeMode: themeProvider.thememode,
            initialRoute: HomeView.routeName,
            routes: {HomeView.routeName: (context) => HomeView()},
          );
        });
  }
}
