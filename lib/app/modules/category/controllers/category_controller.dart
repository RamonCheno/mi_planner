import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miplanner_v2/app/domain/entities/category_entity.dart';
import 'package:miplanner_v2/app/domain/usecases/delete_category_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_categories_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/save_category_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/update_category_usecase.dart';

class CategoryController extends GetxController {
  final GetAllCategoriesUseCase _getAllCategories;
  final SaveCategoryUseCase _saveCategory;
  final UpdateCategoryUseCase _updateCategory;
  final DeleteCategoryUseCase _deleteCategory;

  CategoryController(
    this._getAllCategories,
    this._saveCategory,
    this._updateCategory,
    this._deleteCategory,
  );

  final RxList<CategoryEntity> items = <CategoryEntity>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  static const List<Color> presetColors = [
    Color(0xFF1976D2),
    Color(0xFF2E7D32),
    Color(0xFFD32F2F),
    Color(0xFFF57C00),
    Color(0xFF7B1FA2),
    Color(0xFF00838F),
    Color(0xFFAD1457),
    Color(0xFF558B2F),
  ];

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  Future<void> fetchAll() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      items.value = await _getAllCategories();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createCategory(String name, int color) async {
    try {
      await _saveCategory(CategoryEntity(id: 0, name: name, color: color));
      await fetchAll();
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> updateCategory(CategoryEntity entity) async {
    try {
      await _updateCategory(entity);
      await fetchAll();
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      await _deleteCategory(id);
      items.removeWhere((c) => c.id == id);
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<(String, int)?> showCategoryDialog({CategoryEntity? editing}) async {
    final nameCtrl = TextEditingController(text: editing?.name ?? '');
    final selectedColor = (editing?.color ?? presetColors.first.toARGB32()).obs;

    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text(
          editing == null ? 'category_add_title'.tr : 'category_edit_title'.tr,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(labelText: 'category_name_label'.tr),
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('category_color_label'.tr, style: const TextStyle(fontSize: 12)),
            ),
            const SizedBox(height: 8),
            Obx(
              () => Wrap(
                spacing: 8,
                children: presetColors.map((c) {
                  final isSelected = selectedColor.value == c.toARGB32();
                  return GestureDetector(
                    onTap: () => selectedColor.value = c.toARGB32(),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('cancel'.tr),
          ),
          FilledButton(
            onPressed: () => Get.back(result: true),
            child: Text('save'.tr),
          ),
        ],
      ),
    );

    if (confirmed != true || nameCtrl.text.trim().isEmpty) return null;
    return (nameCtrl.text.trim(), selectedColor.value);
  }
}
