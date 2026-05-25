import 'package:miplanner_v2/app/domain/entities/tasks_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getAll();
  Future<List<TaskEntity>> getAllByCategory(int categoryId);
  Future<TaskEntity?> getById(int id);
  Future<int> save(TaskEntity entity);
  Future<bool> update(TaskEntity entity);
  Future<bool> updateDone(int id, bool isDone);
  Future<bool> delete(int id);
}
