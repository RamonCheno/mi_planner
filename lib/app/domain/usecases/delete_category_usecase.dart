import 'package:miplanner_v2/app/domain/repositories/category_repository.dart';

class DeleteCategoryUseCase {
  final CategoryRepository _repository;
  DeleteCategoryUseCase(this._repository);
  Future<bool> call(int id) async => await _repository.delete(id);
}
