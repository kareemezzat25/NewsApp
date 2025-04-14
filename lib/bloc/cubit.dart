import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/bloc/state.dart';
import 'package:newsapp/models/constants.dart';
import 'package:newsapp/models/newsmodel.dart';
import 'package:newsapp/models/sourcemodel.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitState());

  SourceResponse? sourceResponse;
  NewsResponse? newsResponse;
  int selectedIndex = 0;

  void changeSelectedIndexTab(int index) async {
    selectedIndex = index;
    await getNewsData();
    emit(ChangeSelectedIndexState());
  }

  getSources(String category) async {
    try {
      emit(GetSourcesLoadingState());
      Uri url = Uri.https(Constants.baseurl, "/v2/top-headlines/sources",
          {"apiKey": Constants.apiKey, "category": category});

      http.Response response = await http.get(url);

      var json = jsonDecode(response.body);
      sourceResponse = SourceResponse.fromJson(json);
      await getNewsData();
      emit(GetSourcesSuccessState());
    } catch (e) {
      emit(GetSourcesErrorState());
    }
  }

  Future<void> getNewsData() async {
    try {
      emit(GetNewsLoadingState());
      Uri url = Uri.https(Constants.baseurl, "/v2/everything", {
        "apiKey": Constants.apiKey,
        "sources": sourceResponse?.sources?[selectedIndex].id ?? ""
      });

      http.Response response = await http.get(url);
      var json = jsonDecode(response.body);
      newsResponse = NewsResponse.fromJson(json);
      emit(GetNewsSuccessState());
    } catch (e) {
      emit(GetNewsErrorState());
    }
  }
}
