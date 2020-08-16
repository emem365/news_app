// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$NewsAPI extends NewsAPI {
  _$NewsAPI([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NewsAPI;

  @override
  Future<Response<BuiltList<Source>>> getSources(
      {String category, String language, String country}) {
    final $url = '/sources';
    final $params = <String, dynamic>{
      'category': category,
      'language': language,
      'country': country
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<BuiltList<Source>, Source>($request);
  }

  @override
  Future<Response<HeadlinesResponse>> getTopHeadlinesFromSource(String source) {
    final $url = '/top-headlines';
    final $params = <String, dynamic>{'sources': source};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<HeadlinesResponse, HeadlinesResponse>($request);
  }
}
