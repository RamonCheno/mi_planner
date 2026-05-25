import 'package:get/get.dart';
import 'package:drift/drift.dart' as db;
import 'package:miplanner_v2/app/core/services/database_service.dart';
import 'package:miplanner_v2/app/data/models/tasks_model.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  CAPA: Data  →  Provider  (local via DatabaseService — Drift)           │
// └─────────────────────────────────────────────────────────────────────────┘
//
// Retorna TasksModel directamente sin pasar por Map<String, dynamic>.
// TasksModel.fromDrift() convierte la fila Drift (TasksData) al modelo.
//
// ⚠ Requiere que la tabla exista antes de compilar:
//   cleanarch create table tasks
//   dart run build_runner build --delete-conflicting-outputs
class TaskProvider {
  final _databaseSvc = Get.find<DatabaseService>();

  Future<List<TaskModel>> fetchAll() async {
    final rows = await _databaseSvc.task.getAll();
    return rows.map(TaskModel.fromDrift).toList();
  }

  Future<List<TaskModel>> fetchByCategory(int categoryId) async {
    final rows = await _databaseSvc.task.getByCategory(categoryId);
    return rows.map(TaskModel.fromDrift).toList();
  }

  Future<TaskModel?> fetchById(int id) async {
    final row = await _databaseSvc.task.getById(id);
    return row == null ? null : TaskModel.fromDrift(row);
  }

  Future<int> save(TaskModel model) async => _databaseSvc.task.insert(model.toCompanion());

  Future<bool> update(TaskModel model) =>
      _databaseSvc.task.updateRow(model.toCompanion().copyWith(id: db.Value(model.id)));

  Future<bool> updateDone(int id, bool isDone) => _databaseSvc.task.updateDone(id, isDone);

  Future<bool> delete(int id) async => await _databaseSvc.task.deleteById(id);
}
