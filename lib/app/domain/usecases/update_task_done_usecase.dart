import 'package:miplanner_v2/app/domain/repositories/tasks_repository.dart';

class UpdateTaskDoneUsecase {
  final TaskRepository _repository;
  UpdateTaskDoneUsecase(this._repository);
  Future<bool> call(int id, bool isDone) async => await _repository.updateDone(id, isDone);
}
