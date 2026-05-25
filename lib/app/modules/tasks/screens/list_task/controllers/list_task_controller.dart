import 'package:get/get.dart';
import 'package:miplanner_v2/app/data/dto/task_dto.dart';
import 'package:miplanner_v2/app/core/services/notification_service.dart';
import 'package:miplanner_v2/app/modules/home/controllers/home_controller.dart';
import 'package:miplanner_v2/app/data/models/tasks_model.dart';
import 'package:miplanner_v2/app/domain/entities/category_entity.dart';
import 'package:miplanner_v2/app/domain/entities/tasks_entity.dart';
import 'package:miplanner_v2/app/domain/usecases/delete_task_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_categories_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_taskses_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_tasks_by_category_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/update_task_done_usecase.dart';

class ListTaskController extends GetxController {
  final GetAllTasksUseCase _getAllTasks;
  final GetAllCategoriesUseCase _getAllCategories;
  final GetTasksByCategoryUseCase _getByCategory;
  final UpdateTaskDoneUsecase _updateDone;
  final DeleteTaskUseCase _deleteTask;

  ListTaskController(
    this._getAllTasks,
    this._getAllCategories,
    this._getByCategory,
    this._updateDone,
    this._deleteTask,
  );

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<TaskDto> tasks = <TaskDto>[].obs;
  final RxList<CategoryEntity> categories = <CategoryEntity>[].obs;
  final Rx<int?> selectedCategoryId = Rx<int?>(null);

  @override
  void onInit() {
    super.onInit();
    loadAll();
  }

  Future<void> loadAll() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final results = await Future.wait([
        _getAllTasks(),
        _getAllCategories(),
      ]);
      categories.value = results[1] as List<CategoryEntity>;
      _applyTasks(results[0] as List<TaskEntity>);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> filterByCategory(int? categoryId) async {
    selectedCategoryId.value = categoryId;
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final List<TaskEntity> result;
      if (categoryId == null) {
        result = await _getAllTasks();
      } else {
        result = await _getByCategory(categoryId);
      }
      _applyTasks(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void _applyTasks(List<TaskEntity> raw) {
    tasks.value = raw.map((e) => TaskDto(TaskModel.fromEntity(e))).toList();
  }

  CategoryEntity? categoryOf(int? categoryId) {
    if (categoryId == null) return null;
    try {
      return categories.firstWhere((c) => c.id == categoryId);
    } catch (_) {
      return null;
    }
  }

  Future<void> toggleDone(TaskDto dto) async {
    dto.isDoneObs.toggle();
    try {
      await _updateDone(dto.model.id, dto.isDoneObs.value);
      Get.find<HomeController>().notifyTaskChanged();
    } catch (_) {
      dto.isDoneObs.toggle();
    }
  }

  Future<void> deleteTask(TaskDto dto) async {
    try {
      await _deleteTask(dto.model.id);
      await NotificationService.to.cancelNotification(dto.model.id);
      tasks.removeWhere((t) => t.model.id == dto.model.id);
      Get.find<HomeController>().notifyTaskChanged();
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }
}
