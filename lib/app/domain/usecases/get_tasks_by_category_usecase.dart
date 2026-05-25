import 'package:miplanner_v2/app/domain/entities/tasks_entity.dart';
import 'package:miplanner_v2/app/domain/repositories/tasks_repository.dart';

class GetTasksByCategoryUseCase {
  final TaskRepository _repository;
  GetTasksByCategoryUseCase(this._repository);
  Future<List<TaskEntity>> call(int categoryId) => _repository.getAllByCategory(categoryId);
}
