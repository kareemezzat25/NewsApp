import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/constants.dart';
import 'package:newsapp/models/newsmodel.dart';
import 'package:newsapp/models/sourcemodel.dart';

class ApiManager {
  static Future<SourceResponse> getSources(String category) async {
    Uri url = Uri.https(Constants.baseurl, "/v2/top-headlines/sources",
        {"apiKey": Constants.apiKey, "category": category});

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);
    SourceResponse sourceResponse = SourceResponse.fromJson(json);
    return sourceResponse;
  }

  static Future<NewsResponse> getNews(String sourceId) async {
    Uri url = Uri.https(Constants.baseurl, "/v2/everything",
        {"apiKey": Constants.apiKey, "sources": sourceId});

    http.Response response = await http.get(url);
    var json = jsonDecode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(json);
    return newsResponse;
  }
}
