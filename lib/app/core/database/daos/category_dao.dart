import 'package:drift/drift.dart';
import 'package:miplanner_v2/app/core/database/app_database.dart';
import 'package:miplanner_v2/app/core/database/tables/category_table.dart';

part 'category_dao.g.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  CategoryDao — Queries para la tabla Category                           │
// └─────────────────────────────────────────────────────────────────────────┘
//
// Drift genera dos clases por cada tabla:
//   Category          → definición de la tabla (columnas, PK, etc.)
//   CategoryData    → fila de datos (lo que devuelven las queries)
//   CategoryCompanion → usado para insertar / actualizar
@DriftAccessor(tables: [Category])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(super.db);

  // ── Lecturas ──────────────────────────────────────────────────────────────

  /// Devuelve todos los registros una sola vez.
  Future<List<CategoryData>> getAll() => select(category).get();

  /// Stream reactivo — se actualiza automáticamente al cambiar la tabla.
  Stream<List<CategoryData>> watchAll() => select(category).watch();

  /// Busca por ID. Devuelve null si no existe.
  Future<CategoryData?> getById(int id) =>
      (select(category)..where((t) => t.id.equals(id))).getSingleOrNull();

  // ── Escrituras ────────────────────────────────────────────────────────────

  /// Inserta un nuevo registro. Devuelve el ID generado.
  Future<int> insert(CategoryCompanion entry) =>
      into(category).insert(entry);

  /// Actualiza un registro existente. Devuelve true si se modificó.
  Future<bool> updateRow(CategoryCompanion entry) =>
      (update(category)..where((t) => t.id.equals(entry.id.value)))
          .write(entry)
          .then((n) => n > 0);

  // ── Eliminación ───────────────────────────────────────────────────────────

  /// Elimina por ID. Devuelve true si se eliminó algo.
  Future<bool> deleteById(int id) =>
      (delete(category)..where((t) => t.id.equals(id)))
          .go()
          .then((n) => n > 0);
}
