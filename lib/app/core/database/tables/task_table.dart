import 'package:drift/drift.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  Task — Tabla Drift                                                  │
// └─────────────────────────────────────────────────────────────────────────┘
//
// Tipos de columna disponibles:
//   integer()    → int           text()       → String
//   boolean()    → bool          dateTime()   → DateTime
//   real()       → double        blob()       → Uint8List
//
// Modificadores comunes:
//   .autoIncrement()                        → PK autoincremental
//   .nullable()                             → permite NULL
//   .withDefault(const Constant(valor))     → valor por defecto
//   .references(OtraTabla, #campoId)        → clave foránea (FK)
//
// Regenera después de modificar:
//   dart run build_runner build --delete-conflicting-outputs
import 'package:miplanner_v2/app/core/database/tables/category_table.dart';

class Task extends Table {
  IntColumn      get id          => integer().autoIncrement()();
  TextColumn     get title       => text()();
  TextColumn     get description => text().nullable()();
  IntColumn      get categoryId  => integer().nullable().references(Category, #id)();
  DateTimeColumn get dueDate     => dateTime().nullable()();
  TextColumn     get dueTime     => text().nullable()();
  BoolColumn     get isDone      => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt   => dateTime().withDefault(currentDateAndTime)();
}
