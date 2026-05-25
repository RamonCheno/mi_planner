import 'package:get/get.dart';
import 'package:miplanner_v2/app/core/database/app_database.dart';
import 'package:miplanner_v2/app/core/database/daos/task_dao.dart';
import 'package:miplanner_v2/app/core/database/daos/category_dao.dart';
// cleanarch:dao_import

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  DatabaseService — Almacenamiento local global (Drift)                  │
// └─────────────────────────────────────────────────────────────────────────┘
//
// Drift genera código a partir de tus tablas (@DriftDatabase).
// Corre: dart run build_runner build --delete-conflicting-outputs
//
// Los DAOs se agregan automáticamente con:
//   cleanarch create table <nombre>
//
// O manualmente:
//   import 'package:miplanner_v2/app/core/database/daos/tarea_dao.dart';
//   TareaDao get tarea => _db.tareaDao;
class DatabaseService extends GetxService {
  // La conexión Drift es lazy: se abre en la primera consulta.
  final AppDatabase _db = AppDatabase();

  TaskDao get task => _db.taskDao;
  CategoryDao get category => _db.categoryDao;
  // cleanarch:dao_getter
}
