import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:miplanner_v2/app/core/config/app_config.dart';
import 'package:miplanner_v2/app/core/database/tables/task_table.dart';
import 'package:miplanner_v2/app/core/database/tables/category_table.dart';
// cleanarch:table_import
import 'package:miplanner_v2/app/core/database/daos/task_dao.dart';
import 'package:miplanner_v2/app/core/database/daos/category_dao.dart';
// cleanarch:dao_import

part 'app_database.g.dart';

@DriftDatabase(tables: [Task, Category], daos: [TaskDao, CategoryDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(category);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    return SqfliteQueryExecutor.inDatabaseFolder(
      path: AppConfigProvider.instance.dbName,
    );
  });
}
