import 'package:flutter/material.dart';
import 'package:newsapp/apimanager.dart';
import 'package:newsapp/models/sourcemodel.dart';

class HomeView extends StatelessWidget {
  static const String routeName = "HomeView";
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<SourceResponse>(
      future: ApiManager.getSources(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }
        if (snapshot.hasError) {
          return const Center(child: Text("SomeThing went Wrong"));
        }
        var data = snapshot.data?.sources ?? [];
        return ListView.separated(
            itemBuilder: (context, index) {
              return Text(data[index].name ?? "");
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 12,
              );
            },
            itemCount: data.length ?? 0);
      },
    ));
  }
}
