
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:news_app/src/models/article.dart';
import 'package:news_app/src/models/headlines_response.dart';
import 'package:news_app/src/models/source.dart';
import 'package:news_app/src/models/sources_response.dart';

part 'serializers.g.dart';

@SerializersFor(const [HeadlinesResponse, Article, Source, SourcesResponse])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();