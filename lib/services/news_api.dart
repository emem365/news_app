import 'package:news_app/constants/api_key.dart';
import 'package:news_app/data/response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NewsAPI {
  String url = "https://newsapi.org/v2";
  Response parseResponse(var response) {
    Map jsonResponse = convert.jsonDecode(response.body);
    return Response.fromJson(jsonResponse);
  }

  Future<Response> getTopHeadlinesFromSource(String source) async {
    String requestURL = "$url/top-headlines?sources=$source&apiKey=$apiKey";
    try {
      var response = await http.get(requestURL);
      if (response.statusCode != 200) {
        return Future.error(response.statusCode);
      }
      return parseResponse(response);
    } catch (err) {
      return Future.error(err);
    }
  }
}
