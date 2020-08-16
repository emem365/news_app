import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'source.g.dart';

abstract class Source implements Built<Source, SourceBuilder> {
  String get id;
  String get name;
  @nullable
  String get description;
  @nullable
  String get url;
  @nullable
  String get category;
  @nullable
  String get language;
  @nullable
  String get country;

  Source._();

  factory Source([updates(SourceBuilder b)]) = _$Source;

  static Serializer<Source> get serializer => _$sourceSerializer;
}
