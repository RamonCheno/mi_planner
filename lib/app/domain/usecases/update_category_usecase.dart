import 'package:miplanner_v2/app/domain/entities/category_entity.dart';
import 'package:miplanner_v2/app/domain/repositories/category_repository.dart';

class UpdateCategoryUseCase {
  final CategoryRepository _repository;
  UpdateCategoryUseCase(this._repository);
  Future<bool> call(CategoryEntity entity) async => await _repository.update(entity);
}
