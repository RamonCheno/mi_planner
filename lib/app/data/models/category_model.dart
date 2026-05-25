import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:miplanner_v2/app/domain/entities/category_entity.dart';
import 'package:miplanner_v2/app/core/database/app_database.dart';

part 'category_model.g.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  CAPA: Data  →  Model (Modelo) — @JsonSerializable                      │
// └─────────────────────────────────────────────────────────────────────────┘
//
// fromJson / toJson son generados automáticamente por build_runner.
//
// Después de agregar campos, regenera con:
//   dart run build_runner build --delete-conflicting-outputs
//
// TODO: agrega aquí los campos de tu Category.
//   Ejemplo:
//     final String nombre;
//     final double precio;
//     const CategoryModel({required super.id, required this.nombre, required this.precio});
@JsonSerializable()
class CategoryModel extends CategoryEntity {
  const CategoryModel({required super.id, required super.name, required super.color});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(id: entity.id, name: entity.name, color: entity.color);
  }

  factory CategoryModel.fromDrift(CategoryData row) {
    return CategoryModel(id: row.id, name: row.name, color: row.color);
  }

  CategoryCompanion toCompanion() => CategoryCompanion(name: Value(name), color: Value(color));
}
