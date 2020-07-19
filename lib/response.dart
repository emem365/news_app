import 'package:news_app/article.dart';

class Response {
  String status;
  int totalResults;
  List<Article> articles;

  Response({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory Response.fromJson(Map json) => Response(
        status: json['status'] ?? '',
        totalResults: json['totalResults'] ?? 0,
        articles: json['articles']
                .map<Article>(
                    (jsonArticleObject) => Article.fromJson(jsonArticleObject))
                .toList() ??
            <Article>[],
      );
}
