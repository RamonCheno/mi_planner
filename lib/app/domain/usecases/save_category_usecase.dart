import 'package:miplanner_v2/app/domain/entities/category_entity.dart';
import 'package:miplanner_v2/app/domain/repositories/category_repository.dart';

class SaveCategoryUseCase {
  final CategoryRepository _repository;
  SaveCategoryUseCase(this._repository);
  Future<int> call(CategoryEntity entity) async => await _repository.save(entity);
}
