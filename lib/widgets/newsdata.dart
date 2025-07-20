import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/bloc/cubit.dart';
import 'package:newsapp/bloc/state.dart';
import 'package:newsapp/providers/themeprovider.dart';
import 'package:newsapp/theme.dart';
import 'package:newsapp/widgets/newsItem.dart';
import 'package:provider/provider.dart';

class NewsData extends StatelessWidget {
  Function onBackHome;
  NewsData({super.key, required this.onBackHome});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetNewsLoadingState) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  title: Center(
                    child: CircularProgressIndicator(
                      color: themeProvider.thememode == ThemeMode.light
                          ? MyThemeData.darkColor
                          : MyThemeData.lightColor,
                    ),
                  ),
                );
              });
        }
        if (state is GetNewsErrorState) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    "Error",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  content: Text(
                    state.messageError!,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          onBackHome;
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.r))),
                        child: Text(
                          "Go To Home",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: MyThemeData.lightColor),
                        ))
                  ],
                );
              });
        }
      },
      builder: (context, state) {
        var bloc = BlocProvider.of<HomeCubit>(context);
        var articles = bloc.newsResponse?.articles ?? [];

        return ListView.builder(
            itemBuilder: (context, index) {
              return NewsItem(article: articles[index]);
            },
            itemCount: articles.length);
      },
    );
  }
}
