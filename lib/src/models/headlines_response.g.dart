// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'headlines_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<HeadlinesResponse> _$headlinesResponseSerializer =
    new _$HeadlinesResponseSerializer();

class _$HeadlinesResponseSerializer
    implements StructuredSerializer<HeadlinesResponse> {
  @override
  final Iterable<Type> types = const [HeadlinesResponse, _$HeadlinesResponse];
  @override
  final String wireName = 'HeadlinesResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, HeadlinesResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(String)),
      'totalResults',
      serializers.serialize(object.totalResults,
          specifiedType: const FullType(int)),
      'articles',
      serializers.serialize(object.articles,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Article)])),
    ];

    return result;
  }

  @override
  HeadlinesResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HeadlinesResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'totalResults':
          result.totalResults = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'articles':
          result.articles.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Article)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$HeadlinesResponse extends HeadlinesResponse {
  @override
  final String status;
  @override
  final int totalResults;
  @override
  final BuiltList<Article> articles;

  factory _$HeadlinesResponse(
          [void Function(HeadlinesResponseBuilder) updates]) =>
      (new HeadlinesResponseBuilder()..update(updates)).build();

  _$HeadlinesResponse._({this.status, this.totalResults, this.articles})
      : super._() {
    if (status == null) {
      throw new BuiltValueNullFieldError('HeadlinesResponse', 'status');
    }
    if (totalResults == null) {
      throw new BuiltValueNullFieldError('HeadlinesResponse', 'totalResults');
    }
    if (articles == null) {
      throw new BuiltValueNullFieldError('HeadlinesResponse', 'articles');
    }
  }

  @override
  HeadlinesResponse rebuild(void Function(HeadlinesResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HeadlinesResponseBuilder toBuilder() =>
      new HeadlinesResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HeadlinesResponse &&
        status == other.status &&
        totalResults == other.totalResults &&
        articles == other.articles;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, status.hashCode), totalResults.hashCode),
        articles.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HeadlinesResponse')
          ..add('status', status)
          ..add('totalResults', totalResults)
          ..add('articles', articles))
        .toString();
  }
}

class HeadlinesResponseBuilder
    implements Builder<HeadlinesResponse, HeadlinesResponseBuilder> {
  _$HeadlinesResponse _$v;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  int _totalResults;
  int get totalResults => _$this._totalResults;
  set totalResults(int totalResults) => _$this._totalResults = totalResults;

  ListBuilder<Article> _articles;
  ListBuilder<Article> get articles =>
      _$this._articles ??= new ListBuilder<Article>();
  set articles(ListBuilder<Article> articles) => _$this._articles = articles;

  HeadlinesResponseBuilder();

  HeadlinesResponseBuilder get _$this {
    if (_$v != null) {
      _status = _$v.status;
      _totalResults = _$v.totalResults;
      _articles = _$v.articles?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HeadlinesResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HeadlinesResponse;
  }

  @override
  void update(void Function(HeadlinesResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HeadlinesResponse build() {
    _$HeadlinesResponse _$result;
    try {
      _$result = _$v ??
          new _$HeadlinesResponse._(
              status: status,
              totalResults: totalResults,
              articles: articles.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'articles';
        articles.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'HeadlinesResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
