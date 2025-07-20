import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/constants.dart';
import 'package:newsapp/models/newsmodel.dart';
import 'package:newsapp/models/sourcemodel.dart';
import 'package:newsapp/repository/repo.dart';

class RepoRemoteImplimention extends HomeRepo {
  @override
  Future<SourceResponse> getSources(String catId) async {
    Uri url = Uri.https(Constants.baseurl, "/v2/top-headlines/sources",
        {"apiKey": Constants.apiKey, "category": catId});

    http.Response response = await http.get(url);
    var json = jsonDecode(response.body);
    SourceResponse sourceResponse = SourceResponse.fromJson(json);

    return sourceResponse;
  }

  @override
  Future<NewsResponse> getNewsData(String sourceId) async {
    Uri url = Uri.https(Constants.baseurl, "/v2/everything",
        {"apiKey": Constants.apiKey, "sources": sourceId});

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(json);
    return newsResponse;
  }
}
