import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/moor.dart';
import 'package:news_app/models/source.dart';

part 'persistent_database.g.dart';

class PersistentSources extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [PersistentSources])
class PersistentDatabase extends _$PersistentDatabase {
  PersistentDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  Future<List<PersistentSource>> getAllPersistentSources() =>
      select(persistentSources).get();

  Stream<List<PersistentSource>> watchAllPersistentSources() =>
      select(persistentSources).watch();
  Stream<PersistentSource> watchPersistentSourceIfExists(
          PersistentSource persistentSource) =>
      (select(persistentSources)
            ..where((source) => source.id.equals(persistentSource.id)))
          .watchSingle();
  Future insertPersistentSource(PersistentSource persistentSource) =>
      into(persistentSources).insert(persistentSource);

  Future updatePersistentSource(PersistentSource persistentSource) =>
      update(persistentSources).replace(persistentSource);

  Future deletePersistentSource(PersistentSource persistentSource) =>
      delete(persistentSources).delete(persistentSource);
}

PersistentSource persistentSourceFromSource(Source source) =>
    PersistentSource(id: source.id, name: source.name);
