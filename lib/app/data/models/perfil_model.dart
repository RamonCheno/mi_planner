import 'package:json_annotation/json_annotation.dart';
import 'package:miplanner_v2/app/domain/entities/perfil_entity.dart';

part 'perfil_model.g.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  CAPA: Data  →  Model (Modelo) — @JsonSerializable                      │
// └─────────────────────────────────────────────────────────────────────────┘
//
// fromJson / toJson son generados automáticamente por build_runner.
//
// Después de agregar campos, regenera con:
//   dart run build_runner build --delete-conflicting-outputs
//
// TODO: agrega aquí los campos de tu Perfil.
//   Ejemplo:
//     final String nombre;
//     final double precio;
//     const PerfilModel({required super.id, required this.nombre, required this.precio});
@JsonSerializable()
class PerfilModel extends PerfilEntity {
  const PerfilModel({required super.id});

  // Generado automáticamente por build_runner — no editar
  factory PerfilModel.fromJson(Map<String, dynamic> json) =>
      _$PerfilModelFromJson(json);

  // Generado automáticamente por build_runner — no editar
  Map<String, dynamic> toJson() => _$PerfilModelToJson(this);

  // Convierte una Entidad → Modelo (útil al guardar datos)
  factory PerfilModel.fromEntity(PerfilEntity entity) {
    return PerfilModel(id: entity.id);
  }
  // ── Drift (sin tabla propia) ───────────────────────────────────────────────
  //
  // Este módulo no tiene tabla propia — obtiene datos de otras tablas.
  // Si en el futuro necesitas leer filas de Drift, crea la tabla con:
  //   cleanarch create table perfil
  // y descomenta el factory:
  //
  // import 'package:miplanner_v2/app/core/database/app_database.dart';
  //
  // factory PerfilModel.fromDrift(PerfilData row) {
  //   return PerfilModel(
  //     id: row.id.toString(),
  //     // TODO: mapea los campos de tu tabla
  //   );
  // }
}
