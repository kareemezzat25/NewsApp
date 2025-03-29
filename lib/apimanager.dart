import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/models/sourcemodel.dart';

class ApiManager {
  static Future<SourceResponse> getSources() async {
    Uri url = Uri.https("newsapi.org", "/v2/top-headlines/sources",
        {"apiKey": "0d3f33436c8443e3b16181e95ff478bf"});

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);
    SourceResponse sourceResponse = SourceResponse.fromJson(json);
    return sourceResponse;
  }
}
