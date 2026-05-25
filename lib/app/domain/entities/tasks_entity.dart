// ┌─────────────────────────────────────────────────────────────────────────┐
// │  CAPA: Domain  →  Entity (Entidad)                                      │
// └─────────────────────────────────────────────────────────────────────────┘
//
// ¿Qué es una Entidad?
//   Piénsala como el "molde" de tu objeto de negocio.
//   Si tu app maneja productos, esta clase describe QUÉ ES un producto:
//   tiene id, nombre, precio, etc.
//
// Regla de oro:
//   Esta clase NO sabe nada de internet, bases de datos ni pantallas.
//   Solo describe el objeto. Nada más.
//
//   ✅ Sí puedes poner:   propiedades, constructores, equals/hashCode
//   ❌ No pongas:         llamadas a API, widgets de Flutter, lógica de GetX
//
class TaskEntity {
  final int id;
  final String title;
  final String? description;
  final int? categoryId;
  final DateTime? dueDate;
  final String? dueTime;
  final bool isDone;
  final DateTime createdAt;

  const TaskEntity({
    required this.id,
    required this.title,
    this.description,
    this.categoryId,
    this.dueDate,
    this.dueTime,
    this.isDone = false,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is TaskEntity && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
