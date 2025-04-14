import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc/cubit.dart';
import 'package:newsapp/bloc/state.dart';
import 'package:newsapp/theme.dart';

import 'package:newsapp/widgets/newsItem.dart';

class NewsData extends StatelessWidget {
  NewsData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
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
        if (state is GetNewsErrorState) {
          return Center(
            child: Text(
              "SomeThing went Wrong",
              style: Theme.of(context).textTheme.titleMedium,
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
