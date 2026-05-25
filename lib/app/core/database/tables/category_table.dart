import 'package:drift/drift.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  Category — Tabla Drift                                                  │
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
class Category extends Table {
  IntColumn  get id    => integer().autoIncrement()();
  TextColumn get name  => text()();
  IntColumn  get color => integer().withDefault(const Constant(0xFF2196F3))();
}
