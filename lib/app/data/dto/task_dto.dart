import 'package:get/get.dart';
import 'package:miplanner_v2/app/data/models/tasks_model.dart';

class TaskDto {
  final TaskModel model;
  final RxBool isDoneObs;

  TaskDto(this.model) : isDoneObs = RxBool(model.isDone);

  TaskModel get updateModel => TaskModel(
    id: model.id,
    title: model.title,
    description: model.description,
    categoryId: model.categoryId,
    dueDate: model.dueDate,
    dueTime: model.dueTime,
    isDone: isDoneObs.value,
    createdAt: model.createdAt,
  );
}
