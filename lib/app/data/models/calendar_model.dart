import 'package:json_annotation/json_annotation.dart';
import 'package:miplanner_v2/app/domain/entities/calendar_entity.dart';

part 'calendar_model.g.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  CAPA: Data  →  Model (Modelo) — @JsonSerializable                      │
// └─────────────────────────────────────────────────────────────────────────┘
//
// fromJson / toJson son generados automáticamente por build_runner.
//
// Después de agregar campos, regenera con:
//   dart run build_runner build --delete-conflicting-outputs
//
// TODO: agrega aquí los campos de tu Calendar.
//   Ejemplo:
//     final String nombre;
//     final double precio;
//     const CalendarModel({required super.id, required this.nombre, required this.precio});
@JsonSerializable()
class CalendarModel extends CalendarEntity {
  const CalendarModel({required super.id});

  // Generado automáticamente por build_runner — no editar
  factory CalendarModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarModelFromJson(json);

  // Generado automáticamente por build_runner — no editar
  Map<String, dynamic> toJson() => _$CalendarModelToJson(this);

  // Convierte una Entidad → Modelo (útil al guardar datos)
  factory CalendarModel.fromEntity(CalendarEntity entity) {
    return CalendarModel(id: entity.id);
  }
  // ── Drift (sin tabla propia) ───────────────────────────────────────────────
  //
  // Este módulo no tiene tabla propia — obtiene datos de otras tablas.
  // Si en el futuro necesitas leer filas de Drift, crea la tabla con:
  //   cleanarch create table calendar
  // y descomenta el factory:
  //
  // import 'package:miplanner_v2/app/core/database/app_database.dart';
  //
  // factory CalendarModel.fromDrift(CalendarData row) {
  //   return CalendarModel(
  //     id: row.id.toString(),
  //     // TODO: mapea los campos de tu tabla
  //   );
  // }
}
