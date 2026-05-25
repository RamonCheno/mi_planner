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
class CategoryEntity {
  final int id;
  final String name;
  final int color;

  const CategoryEntity({required this.id, required this.name, required this.color});

  CategoryEntity copyWith({int? id, String? name, int? color}) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is CategoryEntity && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
