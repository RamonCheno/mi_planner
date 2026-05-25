import 'package:miplanner_v2/app/domain/entities/tasks_entity.dart';
import 'package:miplanner_v2/app/domain/repositories/tasks_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository _repository;
  UpdateTaskUseCase(this._repository);
  Future<bool> call(TaskEntity entity) async => await _repository.update(entity);
}
