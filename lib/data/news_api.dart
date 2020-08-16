import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:news_app/constants/api_key.dart';
import 'package:news_app/models/headlines_response.dart';
import 'package:news_app/models/source.dart';
import 'package:news_app/data/built_value_converter.dart';

part 'news_api.chopper.dart';

@ChopperApi()
abstract class NewsAPI extends ChopperService {
  @Get(path: '/sources')
  Future<Response<BuiltList<Source>>> getSources({
    @Query('category') String category,
    @Query('language') String language,
    @Query('country') String country,
  });

  @Get(path: '/top-headlines')
  Future<Response<HeadlinesResponse>> getTopHeadlinesFromSource(@Query('sources') String source);

  static NewsAPI create() {
    final client = ChopperClient(
      baseUrl: 'https://newsapi.org/v2',
      services: [
        _$NewsAPI(),
      ],
      interceptors: [
        addApiKeyInterceptor,
      ],
      converter: BuiltValueConverter(),
    );
    return _$NewsAPI(client);
  }
}

Request addApiKeyInterceptor(Request req) {
  final params = req.parameters;
  params['apiKey'] = apiKey;
  return req.copyWith(parameters: params);
}

// import 'package:news_app/constants/api_key.dart';
// import 'package:news_app/data/response.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;

// class NewsAPI {
//   String url = "https://newsapi.org/v2";
//   Response parseResponse(var response) {
//     Map jsonResponse = convert.jsonDecode(response.body);
//     return Response.fromJson(jsonResponse);
//   }

//   Future<Response> getTopHeadlinesFromSource(String source) async {
//     String requestURL = "$url/top-headlines?sources=$source&apiKey=$apiKey";
//     try {
//       var response = await http.get(requestURL);
//       if (response.statusCode != 200) {
//         return Future.error(response.statusCode);
//       }
//       return parseResponse(response);
//     } catch (err) {
//       return Future.error(err);
//     }
//   }
// }
