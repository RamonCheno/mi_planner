// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dao.dart';

// ignore_for_file: type=lint
mixin _$TaskDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoryTable get category => attachedDatabase.category;
  $TaskTable get task => attachedDatabase.task;
  TaskDaoManager get managers => TaskDaoManager(this);
}

class TaskDaoManager {
  final _$TaskDaoMixin _db;
  TaskDaoManager(this._db);
  $$CategoryTableTableManager get category =>
      $$CategoryTableTableManager(_db.attachedDatabase, _db.category);
  $$TaskTableTableManager get task =>
      $$TaskTableTableManager(_db.attachedDatabase, _db.task);
}
