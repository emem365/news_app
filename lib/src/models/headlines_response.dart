import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:news_app/src/models/article.dart';


part 'headlines_response.g.dart';

abstract class HeadlinesResponse implements Built<HeadlinesResponse, HeadlinesResponseBuilder>{

  String get status;
  int get totalResults;
  BuiltList<Article> get articles;

   HeadlinesResponse._();

  factory HeadlinesResponse([updates(HeadlinesResponseBuilder b)]) = _$HeadlinesResponse;

  static Serializer<HeadlinesResponse> get serializer => _$headlinesResponseSerializer;

}