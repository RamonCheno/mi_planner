import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miplanner_v2/app/core/services/notification_service.dart';
import 'package:miplanner_v2/app/core/services/settings_service.dart';
import 'package:miplanner_v2/app/core/utils/app_logger.dart';
import 'package:miplanner_v2/app/domain/entities/category_entity.dart';
import 'package:miplanner_v2/app/domain/entities/tasks_entity.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_categories_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/save_task_usecase.dart';

class AddTaskController extends GetxController {
  final SaveTaskUsecase _saveTask;
  final GetAllCategoriesUseCase _getAllCategories;

  AddTaskController(this._saveTask, this._getAllCategories);

  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<CategoryEntity> categories = <CategoryEntity>[].obs;
  final Rx<int?> selectedCategoryId = Rx<int?>(null);
  final Rx<DateTime?> dueDate = Rx<DateTime?>(null);
  final Rx<TimeOfDay?> dueTime = Rx<TimeOfDay?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadCategories();
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.onClose();
  }

  Future<void> _loadCategories() async {
    try {
      categories.value = await _getAllCategories();
    } catch (_) {}
  }

  String get formattedDate {
    if (dueDate.value == null) return '';
    final d = dueDate.value!;
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }

  String get formattedTime {
    final is24h = SettingsService.to.isTimeFormat24hObs.value;
    if (dueTime.value == null) return '';
    final t = dueTime.value!;
    if (is24h) {
      return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
    }
    final period = t.hour < 12 ? 'AM' : 'PM';
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    return '${hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')} $period';
  }

  Future<void> save() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    errorMessage.value = '';
    try {
      final entity = TaskEntity(
        id: 0,
        title: titleCtrl.text.trim(),
        description: descCtrl.text.trim().isEmpty ? null : descCtrl.text.trim(),
        categoryId: selectedCategoryId.value,
        dueDate: dueDate.value,
        dueTime: formattedTime.isEmpty ? null : formattedTime,
        createdAt: DateTime.now(),
      );

      final newId = await _saveTask(entity);

      if (dueDate.value != null && dueTime.value != null) {
        final t = dueTime.value!;
        final scheduled = DateTime(
          dueDate.value!.year,
          dueDate.value!.month,
          dueDate.value!.day,
          t.hour,
          t.minute,
        );
        appLogger.debug('[AddTask] Tarea guardada id=$newId — programando notificación para $scheduled');
        await NotificationService.to.scheduleNotification(
          id: newId,
          title: entity.title,
          body: entity.description ?? 'task_pending_body'.tr,
          scheduledDate: scheduled,
        );
      } else {
        appLogger.debug('[AddTask] Tarea guardada id=$newId — sin hora, no se programa notificación.');
      }

      Get.back(result: true);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
