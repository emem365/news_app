// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sources_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SourcesResponse> _$sourcesResponseSerializer =
    new _$SourcesResponseSerializer();

class _$SourcesResponseSerializer
    implements StructuredSerializer<SourcesResponse> {
  @override
  final Iterable<Type> types = const [SourcesResponse, _$SourcesResponse];
  @override
  final String wireName = 'SourcesResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, SourcesResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(String)),
      'sources',
      serializers.serialize(object.sources,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Source)])),
    ];

    return result;
  }

  @override
  SourcesResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SourcesResponseBuilder();

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
        case 'sources':
          result.sources.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Source)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$SourcesResponse extends SourcesResponse {
  @override
  final String status;
  @override
  final BuiltList<Source> sources;

  factory _$SourcesResponse([void Function(SourcesResponseBuilder) updates]) =>
      (new SourcesResponseBuilder()..update(updates)).build();

  _$SourcesResponse._({this.status, this.sources}) : super._() {
    if (status == null) {
      throw new BuiltValueNullFieldError('SourcesResponse', 'status');
    }
    if (sources == null) {
      throw new BuiltValueNullFieldError('SourcesResponse', 'sources');
    }
  }

  @override
  SourcesResponse rebuild(void Function(SourcesResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SourcesResponseBuilder toBuilder() =>
      new SourcesResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SourcesResponse &&
        status == other.status &&
        sources == other.sources;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, status.hashCode), sources.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SourcesResponse')
          ..add('status', status)
          ..add('sources', sources))
        .toString();
  }
}

class SourcesResponseBuilder
    implements Builder<SourcesResponse, SourcesResponseBuilder> {
  _$SourcesResponse _$v;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  ListBuilder<Source> _sources;
  ListBuilder<Source> get sources =>
      _$this._sources ??= new ListBuilder<Source>();
  set sources(ListBuilder<Source> sources) => _$this._sources = sources;

  SourcesResponseBuilder();

  SourcesResponseBuilder get _$this {
    if (_$v != null) {
      _status = _$v.status;
      _sources = _$v.sources?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SourcesResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SourcesResponse;
  }

  @override
  void update(void Function(SourcesResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SourcesResponse build() {
    _$SourcesResponse _$result;
    try {
      _$result = _$v ??
          new _$SourcesResponse._(status: status, sources: sources.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'sources';
        sources.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SourcesResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
