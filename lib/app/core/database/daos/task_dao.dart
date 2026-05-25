import 'package:drift/drift.dart';
import 'package:miplanner_v2/app/core/database/app_database.dart';
import 'package:miplanner_v2/app/core/database/tables/task_table.dart';

part 'task_dao.g.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  TaskDao — Queries para la tabla Task                           │
// └─────────────────────────────────────────────────────────────────────────┘
//
// Drift genera dos clases por cada tabla:
//   Task          → definición de la tabla (columnas, PK, etc.)
//   TaskData    → fila de datos (lo que devuelven las queries)
//   TaskCompanion → usado para insertar / actualizar
@DriftAccessor(tables: [Task])
class TaskDao extends DatabaseAccessor<AppDatabase>
    with _$TaskDaoMixin {
  TaskDao(super.db);

  // ── Lecturas ──────────────────────────────────────────────────────────────

  /// Devuelve todos los registros una sola vez.
  Future<List<TaskData>> getAll() => select(task).get();

  /// Stream reactivo — se actualiza automáticamente al cambiar la tabla.
  Stream<List<TaskData>> watchAll() => select(task).watch();

  /// Busca por ID. Devuelve null si no existe.
  Future<TaskData?> getById(int id) =>
      (select(task)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<TaskData>> getByCategory(int categoryId) =>
      (select(task)..where((t) => t.categoryId.equals(categoryId))).get();

  // ── Escrituras ────────────────────────────────────────────────────────────

  /// Inserta un nuevo registro. Devuelve el ID generado.
  Future<int> insert(TaskCompanion entry) =>
      into(task).insert(entry);

  /// Actualiza un registro existente. Devuelve true si se modificó.
  Future<bool> updateRow(TaskCompanion entry) =>
      (update(task)..where((t) => t.id.equals(entry.id.value)))
          .write(entry)
          .then((n) => n > 0);

  Future<bool> updateDone(int id, bool isDone) =>
      (update(task)..where((t) => t.id.equals(id)))
          .write(TaskCompanion(isDone: Value(isDone)))
          .then((n) => n > 0);

  // ── Eliminación ───────────────────────────────────────────────────────────

  /// Elimina por ID. Devuelve true si se eliminó algo.
  Future<bool> deleteById(int id) =>
      (delete(task)..where((t) => t.id.equals(id)))
          .go()
          .then((n) => n > 0);
}
