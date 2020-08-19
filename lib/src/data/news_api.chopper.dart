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
  Future<Response<SourcesResponse>> getSources(
      {String category, String language, String country}) {
    final $url = '/sources';
    final $params = <String, dynamic>{
      'category': category,
      'language': language,
      'country': country
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<SourcesResponse, SourcesResponse>($request);
  }

  @override
  Future<Response<HeadlinesResponse>> getEverything(
      {String query,
      String queryInTitle,
      List<String> sources,
      List<String> domains,
      List<String> excludeDomains,
      String from,
      String to,
      String language,
      String sortBy,
      int pageSize,
      int page}) {
    final $url = '/everything';
    final $params = <String, dynamic>{
      'q': query,
      'qInTitle': queryInTitle,
      'sources': sources,
      'domains': domains,
      'excludeDomains': excludeDomains,
      'from': from,
      'to': to,
      'language': language,
      'sortBy': sortBy,
      'pageSize': pageSize,
      'page': page
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<HeadlinesResponse, HeadlinesResponse>($request);
  }

  @override
  Future<Response<HeadlinesResponse>> getTopHeadlinesFromSource(String source) {
    final $url = '/top-headlines';
    final $params = <String, dynamic>{'sources': source};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<HeadlinesResponse, HeadlinesResponse>($request);
  }
}
