import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:miplanner_v2/app/domain/entities/tasks_entity.dart';
import 'package:miplanner_v2/app/core/database/app_database.dart';

part 'tasks_model.g.dart';

@JsonSerializable()
class TaskModel extends TaskEntity {
  const TaskModel({
    required super.id,
    required super.title,
    super.description,
    super.categoryId,
    super.dueDate,
    super.dueTime,
    super.isDone,
    required super.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      categoryId: entity.categoryId,
      dueDate: entity.dueDate,
      dueTime: entity.dueTime,
      isDone: entity.isDone,
      createdAt: entity.createdAt,
    );
  }

  factory TaskModel.fromDrift(TaskData row) {
    return TaskModel(
      id: row.id,
      title: row.title,
      description: row.description,
      categoryId: row.categoryId,
      dueDate: row.dueDate,
      dueTime: row.dueTime,
      isDone: row.isDone,
      createdAt: row.createdAt,
    );
  }

  TaskCompanion toCompanion() => TaskCompanion(
    title: Value(title),
    description: Value(description),
    categoryId: Value(categoryId),
    dueDate: Value(dueDate),
    dueTime: Value(dueTime),
    isDone: Value(isDone),
  );
}
