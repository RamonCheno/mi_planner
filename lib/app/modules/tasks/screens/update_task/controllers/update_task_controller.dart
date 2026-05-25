import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miplanner_v2/app/core/services/notification_service.dart';
import 'package:miplanner_v2/app/core/services/settings_service.dart';
import 'package:miplanner_v2/app/core/utils/app_logger.dart';
import 'package:miplanner_v2/app/domain/entities/category_entity.dart';
import 'package:miplanner_v2/app/domain/entities/tasks_entity.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_categories_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_tasks_by_id_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/update_task_usecase.dart';

class UpdateTaskController extends GetxController {
  final GetTaskByIdUseCase _getById;
  final UpdateTaskUseCase _updateTask;
  final GetAllCategoriesUseCase _getAllCategories;

  UpdateTaskController(this._getById, this._updateTask, this._getAllCategories);

  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<CategoryEntity> categories = <CategoryEntity>[].obs;
  final Rx<int?> selectedCategoryId = Rx<int?>(null);
  final Rx<DateTime?> dueDate = Rx<DateTime?>(null);
  final Rx<TimeOfDay?> dueTime = Rx<TimeOfDay?>(null);

  int _taskId = 0;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    final id = args?['id'] as int? ?? 0;
    _load(id);
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.onClose();
  }

  Future<void> _load(int id) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final results = await Future.wait([
        _getById(id),
        _getAllCategories(),
      ]);
      final task = results[0] as TaskEntity?;
      categories.value = results[1] as List<CategoryEntity>;

      if (task != null) {
        _taskId = task.id;
        titleCtrl.text = task.title;
        descCtrl.text = task.description ?? '';
        selectedCategoryId.value = task.categoryId;
        dueDate.value = task.dueDate;
        if (task.dueTime != null) {
          dueTime.value = _parseTime(task.dueTime!);
        }
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  TimeOfDay? _parseTime(String time) {
    try {
      final parts = time.split(':');
      int hour = int.parse(parts[0].trim());
      final minPart = parts[1].trim();
      int minute;
      if (minPart.contains(' ')) {
        final mp = minPart.split(' ');
        minute = int.parse(mp[0]);
        if (mp[1].toUpperCase() == 'PM' && hour < 12) hour += 12;
        if (mp[1].toUpperCase() == 'AM' && hour == 12) hour = 0;
      } else {
        minute = int.parse(minPart);
      }
      return TimeOfDay(hour: hour, minute: minute);
    } catch (_) {
      return null;
    }
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
        id: _taskId,
        title: titleCtrl.text.trim(),
        description: descCtrl.text.trim().isEmpty ? null : descCtrl.text.trim(),
        categoryId: selectedCategoryId.value,
        dueDate: dueDate.value,
        dueTime: formattedTime.isEmpty ? null : formattedTime,
        createdAt: DateTime.now(),
      );

      await _updateTask(entity);

      appLogger.debug('[UpdateTask] Cancelando notificacion anterior id=$_taskId');
      await NotificationService.to.cancelNotification(_taskId);
      if (dueDate.value != null && dueTime.value != null) {
        final t = dueTime.value!;
        final scheduled = DateTime(
          dueDate.value!.year,
          dueDate.value!.month,
          dueDate.value!.day,
          t.hour,
          t.minute,
        );
        appLogger.debug('[UpdateTask] Tarea actualizada id=$_taskId - programando notificacion para $scheduled');
        await NotificationService.to.scheduleNotification(
          id: _taskId,
          title: entity.title,
          body: entity.description ?? 'task_pending_body'.tr,
          scheduledDate: scheduled,
        );
      } else {
        appLogger.debug('[UpdateTask] Tarea actualizada id=$_taskId - sin hora, no se programa notificacion.');
      }

      Get.back(result: true);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
