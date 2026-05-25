import 'package:miplanner_v2/app/domain/entities/tasks_entity.dart';
import 'package:miplanner_v2/app/domain/repositories/tasks_repository.dart';

class SaveTaskUsecase {
  final TaskRepository _repository;
  SaveTaskUsecase(this._repository);
  Future<int> call(TaskEntity entity) async => await _repository.save(entity);
}
