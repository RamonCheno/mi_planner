# Base de datos — Drift

> ORM SQLite con code-gen y soporte reactivo (streams).

## Índice

- [Crear una tabla](#crear-una-tabla)
- [CRUD básico](#crud-básico)
- [Streams reactivos](#streams-reactivos)
- [Relaciones](#relaciones)
- [Queries avanzadas](#queries-avanzadas)
- [Transacciones](#transacciones)
- [Migraciones](#migraciones)

---

## Crear una tabla

```bash
cleanarch create table nombre_tabla
dart run build_runner build --delete-conflicting-outputs
```

Genera:
```
lib/app/core/database/
├── tables/nombre_tabla_table.dart   ← define las columnas
└── daos/nombre_tabla_dao.dart       ← CRUD generado
```

### Ejemplo de tabla completa

```dart
// tables/tarea_table.dart
class Tarea extends Table {
  IntColumn    get id          => integer().autoIncrement()();
  TextColumn   get titulo      => text()();
  TextColumn   get descripcion => text().nullable()();
  BoolColumn   get completada  => boolean().withDefault(const Constant(false))();
  DateTimeColumn get creadaEn  => dateTime().withDefault(currentDateAndTime)();
  IntColumn    get categoriaId => integer().nullable().references(Categoria, #id)();
}
```

---

## CRUD básico

```dart
final db = Get.find<DatabaseService>();

// Insertar — devuelve el ID generado
final id = await db.tarea.insert(
  TareaCompanion(
    titulo:      Value('Comprar leche'),
    descripcion: Value('En el supermercado'),
  ),
);

// Leer todos
final tareas = await db.tarea.getAll();

// Leer por ID
final tarea = await db.tarea.getById(1);

// Actualizar — solo los campos con Value() se modifican
await db.tarea.updateRow(
  TareaCompanion(
    id:         Value(1),
    completada: Value(true),
  ),
);

// Eliminar
await db.tarea.deleteById(1);
```

---

## Streams reactivos

```dart
// En el Controller — se actualiza automáticamente al cambiar la tabla
@override
void onInit() {
  super.onInit();
  db.tarea.watchAll().listen((lista) => tareas.value = lista);
}
```

---

## Relaciones

### Definir FK en la tabla

```dart
class Tarea extends Table {
  IntColumn get categoriaId =>
      integer().nullable().references(Categoria, #id)();
}
```

### Query JOIN en el DAO

```dart
// En tarea_dao.dart
class TareaConCategoria {
  final TareaData tarea;
  final CategoriaData? categoria;
  const TareaConCategoria(this.tarea, this.categoria);
}

@DriftAccessor(tables: [Tarea, Categoria])
class TareaDao extends DatabaseAccessor<AppDatabase>
    with _$TareaDaoMixin {

  Future<List<TareaConCategoria>> getAllConCategoria() {
    final query = select(tarea).join([
      leftOuterJoin(categoria,
          categoria.id.equalsExp(tarea.categoriaId)),
    ]);
    return query.map((row) => TareaConCategoria(
      row.readTable(tarea),
      row.readTableOrNull(categoria),
    )).get();
  }

  Stream<List<TareaConCategoria>> watchAllConCategoria() {
    return (select(tarea).join([
      leftOuterJoin(categoria,
          categoria.id.equalsExp(tarea.categoriaId)),
    ])).watch().map((rows) => rows.map((row) => TareaConCategoria(
      row.readTable(tarea),
      row.readTableOrNull(categoria),
    )).toList());
  }
}
```

---

## Queries avanzadas

```dart
// Filtrar — solo completadas
Future<List<TareaData>> getCompletadas() =>
    (select(tarea)..where((t) => t.completada.equals(true))).get();

// Buscar por texto
Future<List<TareaData>> buscar(String texto) =>
    (select(tarea)..where((t) => t.titulo.contains(texto))).get();

// Ordenar por fecha descendente
Future<List<TareaData>> getOrdenadas() =>
    (select(tarea)..orderBy([(t) => OrderingTerm.desc(t.creadaEn)])).get();

// Paginación
Future<List<TareaData>> getPagina(int pagina, {int porPagina = 20}) =>
    (select(tarea)
          ..orderBy([(t) => OrderingTerm.desc(t.creadaEn)])
          ..limit(porPagina, offset: pagina * porPagina))
        .get();

// Contar registros
Future<int> contar() async {
  final count = tarea.id.count();
  final query = selectOnly(tarea)..addColumns([count]);
  return (await query.getSingle()).read(count) ?? 0;
}
```

---

## Transacciones

```dart
// Operaciones atómicas
Future<void> insertarTareaConCategoria(
  TareaCompanion nuevaTarea,
  CategoriaCompanion nuevaCategoria,
) async {
  await transaction(() async {
    final catId = await into(categoria).insert(nuevaCategoria);
    await into(tarea).insert(
      nuevaTarea.copyWith(categoriaId: Value(catId)),
    );
  });
}
```

---

## Migraciones

```dart
// En app_database.dart
@override
int get schemaVersion => 2; // incrementar al cambiar schema

@override
MigrationStrategy get migration => MigrationStrategy(
  onCreate: (m) async => await m.createAll(),
  onUpgrade: (m, from, to) async {
    if (from < 2) {
      await m.addColumn(tarea, tarea.descripcion);
    }
  },
);
```
