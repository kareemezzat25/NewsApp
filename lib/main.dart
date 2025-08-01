import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/bloc/bloc_observer.dart';
import 'package:newsapp/home.dart';
import 'package:newsapp/internet_service.dart';
import 'package:newsapp/models/cache.dart';
import 'package:newsapp/providers/themeprovider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/splashview.dart';
import 'package:newsapp/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Cache.init();
  await EasyLocalization.ensureInitialized();
  InternetService().init();
  Bloc.observer = MyBlocObserver();
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: const NewsApp())));
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

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
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: MyThemeData.lightTheme,
            darkTheme: MyThemeData.darkTheme,
            themeMode: themeProvider.thememode,
            initialRoute: SplashView.routeName,
            routes: {
              HomeView.routeName: (context) => const HomeView(),
              SplashView.routeName: (context) => SplashView()
            },
          );
        });
  }
}
