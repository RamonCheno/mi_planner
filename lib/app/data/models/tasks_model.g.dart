// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  categoryId: (json['categoryId'] as num?)?.toInt(),
  dueDate: json['dueDate'] == null
      ? null
      : DateTime.parse(json['dueDate'] as String),
  dueTime: json['dueTime'] as String?,
  isDone: json['isDone'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'categoryId': instance.categoryId,
  'dueDate': instance.dueDate?.toIso8601String(),
  'dueTime': instance.dueTime,
  'isDone': instance.isDone,
  'createdAt': instance.createdAt.toIso8601String(),
};
