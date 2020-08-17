// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class PersistentSource extends DataClass
    implements Insertable<PersistentSource> {
  final String id;
  final String name;
  PersistentSource({@required this.id, @required this.name});
  factory PersistentSource.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return PersistentSource(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  PersistentSourcesCompanion toCompanion(bool nullToAbsent) {
    return PersistentSourcesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory PersistentSource.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PersistentSource(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  PersistentSource copyWith({String id, String name}) => PersistentSource(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('PersistentSource(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PersistentSource &&
          other.id == this.id &&
          other.name == this.name);
}

class PersistentSourcesCompanion extends UpdateCompanion<PersistentSource> {
  final Value<String> id;
  final Value<String> name;
  const PersistentSourcesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  PersistentSourcesCompanion.insert({
    @required String id,
    @required String name,
  })  : id = Value(id),
        name = Value(name);
  static Insertable<PersistentSource> custom({
    Expression<String> id,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  PersistentSourcesCompanion copyWith({Value<String> id, Value<String> name}) {
    return PersistentSourcesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersistentSourcesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $PersistentSourcesTable extends PersistentSources
    with TableInfo<$PersistentSourcesTable, PersistentSource> {
  final GeneratedDatabase _db;
  final String _alias;
  $PersistentSourcesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $PersistentSourcesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'persistent_sources';
  @override
  final String actualTableName = 'persistent_sources';
  @override
  VerificationContext validateIntegrity(Insertable<PersistentSource> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersistentSource map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PersistentSource.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PersistentSourcesTable createAlias(String alias) {
    return $PersistentSourcesTable(_db, alias);
  }
}

abstract class _$PersistentDatabase extends GeneratedDatabase {
  _$PersistentDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  $PersistentSourcesTable _persistentSources;
  $PersistentSourcesTable get persistentSources =>
      _persistentSources ??= $PersistentSourcesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [persistentSources];
}
