import 'package:get/get.dart';
import 'package:drift/drift.dart' as db;
import 'package:miplanner_v2/app/core/services/database_service.dart';
import 'package:miplanner_v2/app/data/models/category_model.dart';

class CategoryProvider {
  final _databaseSvc = Get.find<DatabaseService>();

  Future<List<CategoryModel>> fetchAll() async {
    final rows = await _databaseSvc.category.getAll();
    return rows.map(CategoryModel.fromDrift).toList();
  }

  Future<CategoryModel?> fetchById(int id) async {
    final row = await _databaseSvc.category.getById(id);
    return row == null ? null : CategoryModel.fromDrift(row);
  }

  Future<int> save(CategoryModel model) async =>
      await _databaseSvc.category.insert(model.toCompanion());

  Future<bool> update(CategoryModel model) async =>
      await _databaseSvc.category.updateRow(model.toCompanion().copyWith(id: db.Value(model.id)));

  Future<bool> delete(int id) async => await _databaseSvc.category.deleteById(id);
}
