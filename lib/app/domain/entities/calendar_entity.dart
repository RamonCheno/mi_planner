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
// TODO: Agrega aquí las propiedades de tu Calendar.
class CalendarEntity {
  final String id;

  const CalendarEntity({required this.id});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalendarEntity && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
