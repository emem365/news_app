import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:news_app/src/models/source.dart';

part 'sources_response.g.dart';

abstract class SourcesResponse implements Built<SourcesResponse, SourcesResponseBuilder>{

  String get status;
  BuiltList<Source> get sources;

   SourcesResponse._();

  factory SourcesResponse([updates(SourcesResponseBuilder b)]) = _$SourcesResponse;

  static Serializer<SourcesResponse> get serializer => _$sourcesResponseSerializer;

}