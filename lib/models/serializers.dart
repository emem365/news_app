
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/headlines_response.dart';
import 'package:news_app/models/source.dart';
import 'package:news_app/models/sources_response.dart';

part 'serializers.g.dart';

@SerializersFor(const [HeadlinesResponse, Article, Source, SourcesResponse])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();