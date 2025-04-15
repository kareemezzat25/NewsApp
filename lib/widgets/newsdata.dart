import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/bloc/cubit.dart';
import 'package:newsapp/bloc/state.dart';
import 'package:newsapp/theme.dart';
import 'package:newsapp/widgets/newsItem.dart';

class NewsData extends StatelessWidget {
  Function onBackHome;
  NewsData({super.key, required this.onBackHome});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
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
        if (state is GetNewsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: MyThemeData.darkColor,
            ),
          );
        }
        if (articles.isEmpty) {
          return Center(
            child: Text(
              "There Is no Data exist",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          );
        }
        return ListView.builder(
            itemBuilder: (context, index) {
              return NewsItem(article: articles[index]);
            },
            itemCount: articles.length ?? 0);
      },
    );
  }
}
