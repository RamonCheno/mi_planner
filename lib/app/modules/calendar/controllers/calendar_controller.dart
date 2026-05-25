import 'package:get/get.dart';
import 'package:miplanner_v2/app/data/dto/task_dto.dart';
import 'package:miplanner_v2/app/data/models/tasks_model.dart';
import 'package:miplanner_v2/app/domain/entities/tasks_entity.dart';
import 'package:miplanner_v2/app/domain/usecases/delete_task_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_taskses_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/update_task_done_usecase.dart';
import 'package:miplanner_v2/app/core/services/notification_service.dart';
import 'package:miplanner_v2/app/modules/home/controllers/home_controller.dart';

class CalendarController extends GetxController {
  final GetAllTasksUseCase _getAllTasks;
  final UpdateTaskDoneUsecase _updateDone;
  final DeleteTaskUseCase _deleteTask;

  CalendarController(this._getAllTasks, this._updateDone, this._deleteTask);

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<TaskEntity> allTasks = <TaskEntity>[].obs;
  final RxList<TaskDto> dayTasks = <TaskDto>[].obs;
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    _selectDay(DateTime.now());
    loadAll();
  }

  Future<void> loadAll() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      allTasks.value = await _getAllTasks();
      _updateDayTasks();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void onDaySelected(DateTime day, DateTime focused) {
    _selectDay(day);
    focusedDay.value = focused;
  }

  void _selectDay(DateTime day) {
    selectedDay.value = day;
    _updateDayTasks();
  }

  void _updateDayTasks() {
    final day = selectedDay.value ?? DateTime.now();
    final filtered = allTasks.where((t) {
      if (t.dueDate == null) return false;
      final d = t.dueDate!;
      return d.year == day.year && d.month == day.month && d.day == day.day;
    }).toList();
    dayTasks.value = filtered.map((t) => TaskDto(TaskModel.fromEntity(t))).toList();
  }

  List<TaskEntity> getEventsForDay(DateTime day) {
    return allTasks.where((t) {
      if (t.dueDate == null) return false;
      final d = t.dueDate!;
      return d.year == day.year && d.month == day.month && d.day == day.day;
    }).toList();
  }

  Future<void> toggleDone(TaskDto dto) async {
    dto.isDoneObs.toggle();
    try {
      await _updateDone(dto.updateModel.id, dto.isDoneObs.value);
      final idx = allTasks.indexWhere((t) => t.id == dto.model.id);
      if (idx != -1) {
        final old = allTasks[idx];
        allTasks[idx] = TaskEntity(
          id: old.id,
          title: old.title,
          description: old.description,
          categoryId: old.categoryId,
          dueDate: old.dueDate,
          dueTime: old.dueTime,
          isDone: dto.isDoneObs.value,
          createdAt: old.createdAt,
        );
      }
      Get.find<HomeController>().notifyTaskChanged();
    } catch (_) {
      dto.isDoneObs.toggle();
    }
  }

  Future<void> deleteTask(TaskDto dto) async {
    try {
      await _deleteTask(dto.model.id);
      await NotificationService.to.cancelNotification(dto.model.id);
      allTasks.removeWhere((t) => t.id == dto.model.id);
      dayTasks.removeWhere((d) => d.model.id == dto.model.id);
      Get.find<HomeController>().notifyTaskChanged();
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }
}
