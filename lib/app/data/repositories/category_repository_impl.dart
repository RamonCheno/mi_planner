import 'package:miplanner_v2/app/domain/entities/category_entity.dart';
import 'package:miplanner_v2/app/domain/repositories/category_repository.dart';
import 'package:miplanner_v2/app/data/models/category_model.dart';
import 'package:miplanner_v2/app/data/providers/category_provider.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  CAPA: Data  →  RepositoryImpl  (datasource local ORM)                  │
// └─────────────────────────────────────────────────────────────────────────┘
//
// Flujo de datos (sin conversión Map):
//   Base de datos
//       ↓  (CategoryData / objeto ORM)
//   CategoryProvider          ← llama al DAO de DatabaseService
//       ↓  (CategoryModel)    ← fromDrift / fromOrm convierte directo
//   Tu Controller / UseCase    ← trabaja con CategoryModel (que ES CategoryEntity)
//
// CategoryModel extiende CategoryEntity, así que el repositorio devuelve
// los modelos tal cual — sin conversión adicional.
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryProvider _provider;

  CategoryRepositoryImpl(this._provider);

  @override
  Future<List<CategoryEntity>> getAll() async => _provider.fetchAll();

  @override
  Future<CategoryEntity?> getById(int categoryId) async => _provider.fetchById(categoryId);

  @override
  Future<int> save(CategoryEntity entity) async =>
      await _provider.save(CategoryModel.fromEntity(entity));

  @override
  Future<bool> delete(int id) async => await _provider.delete(id);

  @override
  Future<bool> update(CategoryEntity entity) async =>
      await _provider.update(CategoryModel.fromEntity(entity));
}
