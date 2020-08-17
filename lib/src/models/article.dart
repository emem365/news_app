import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:news_app/src/models/source.dart';

part 'article.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  Source get source;
  @nullable
  String get author;
  String get title;
  @nullable
  String get description;
  String get url;
  @nullable
  String get urlToImage;
  String get publishedAt;
  @nullable
  String get content;

  Article._();

  factory Article([updates(ArticleBuilder b)]) = _$Article;

  static Serializer<Article> get serializer => _$articleSerializer;
}
