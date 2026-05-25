import 'package:get/get.dart';
import 'package:miplanner_v2/app/domain/entities/tasks_entity.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_taskses_usecase.dart';

class PerfilController extends GetxController {
  final GetAllTasksUseCase _getAllTasks;

  PerfilController(this._getAllTasks);

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt totalTasks = 0.obs;
  final RxInt doneTasks = 0.obs;
  final RxInt pendingTasks = 0.obs;
  final RxInt overdueTasks = 0.obs;

  double get completionRate => totalTasks.value == 0 ? 0 : doneTasks.value / totalTasks.value;

  @override
  void onInit() {
    super.onInit();
    loadStats();
  }

  Future<void> loadStats() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final tasks = await _getAllTasks();
      _calcStats(tasks);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void _calcStats(List<TaskEntity> tasks) {
    final now = DateTime.now();
    totalTasks.value = tasks.length;
    doneTasks.value = tasks.where((t) => t.isDone).length;
    pendingTasks.value = tasks.where((t) => !t.isDone).length;
    overdueTasks.value = tasks.where((t) {
      if (t.isDone || t.dueDate == null) return false;
      return _dueDateTime(t.dueDate!, t.dueTime).isBefore(now);
    }).length;
  }

  /// Combina fecha y hora de vencimiento en un solo [DateTime].
  ///
  /// - Con hora: vence en la hora exacta del día indicado.
  /// - Sin hora: vence al final del día (23:59:59) para no marcarla
  ///   como vencida hasta que el día completo haya pasado.
  DateTime _dueDateTime(DateTime date, String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) {
      return DateTime(date.year, date.month, date.day, 23, 59, 59);
    }
    try {
      final parts = timeStr.split(':');
      int hour = int.parse(parts[0].trim());
      final minPart = parts[1].trim();
      final int minute;
      if (minPart.contains(' ')) {
        final mp = minPart.split(' ');
        minute = int.parse(mp[0]);
        if (mp[1].toUpperCase() == 'PM' && hour < 12) hour += 12;
        if (mp[1].toUpperCase() == 'AM' && hour == 12) hour = 0;
      } else {
        minute = int.parse(minPart);
      }
      return DateTime(date.year, date.month, date.day, hour, minute);
    } catch (_) {
      return DateTime(date.year, date.month, date.day, 23, 59, 59);
    }
  }
}
