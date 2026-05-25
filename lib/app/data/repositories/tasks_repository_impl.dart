import 'package:miplanner_v2/app/domain/entities/tasks_entity.dart';
import 'package:miplanner_v2/app/domain/repositories/tasks_repository.dart';
import 'package:miplanner_v2/app/data/models/tasks_model.dart';
import 'package:miplanner_v2/app/data/providers/tasks_provider.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskProvider _provider;

  TaskRepositoryImpl(this._provider);

  @override
  Future<List<TaskEntity>> getAll() => _provider.fetchAll();

  @override
  Future<List<TaskEntity>> getAllByCategory(int categoryId) => _provider.fetchByCategory(categoryId);

  @override
  Future<TaskEntity?> getById(int id) => _provider.fetchById(id);

  @override
  Future<int> save(TaskEntity entity) async =>
      await _provider.save(TaskModel.fromEntity(entity));

  @override
  Future<bool> delete(int id) => _provider.delete(id);

  @override
  Future<bool> update(TaskEntity entity) async =>
      await _provider.update(TaskModel.fromEntity(entity));

  @override
  Future<bool> updateDone(int id, bool isDone) async =>
      await _provider.updateDone(id, isDone);
}
