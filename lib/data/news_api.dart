import 'package:chopper/chopper.dart';
import 'package:news_app/constants/api_key.dart';
import 'package:news_app/models/headlines_response.dart';
import 'package:news_app/data/built_value_converter.dart';
import 'package:news_app/models/sources_response.dart';

part 'news_api.chopper.dart';

@ChopperApi()
abstract class NewsAPI extends ChopperService {
  @Get(path: '/sources')
  Future<Response<SourcesResponse>> getSources({
    @Query('category') String category,
    @Query('language') String language,
    @Query('country') String country,
  });

  @Get(path:'/everything')
  Future<Response<HeadlinesResponse>> getEverything({
    @Query('q') String query,
    @Query('qInTitle') String queryInTitle,
    @Query('sources') List<String> sources,
    @Query('domains') List<String> domains,
    @Query('excludeDomains') List<String> excludeDomains,
    @Query('from') String from,
    @Query('to') String to,
    @Query('language') String language,
    @Query('sortBy') String sortBy,
    @Query('pageSize') String pageSize,
    @Query('page') String page,
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