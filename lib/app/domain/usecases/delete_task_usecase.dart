import 'package:miplanner_v2/app/domain/repositories/tasks_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository _repository;
  DeleteTaskUseCase(this._repository);
  Future<bool> call(int id) async => await _repository.delete(id);
}
