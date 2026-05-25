import 'package:get/get.dart';
import 'package:miplanner_v2/app/domain/usecases/delete_task_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_categories_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_taskses_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_tasks_by_category_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/update_task_done_usecase.dart';
import 'package:miplanner_v2/app/modules/tasks/screens/list_task/controllers/list_task_controller.dart';

class ListTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListTaskController>(
      () => ListTaskController(
        Get.find<GetAllTasksUseCase>(),
        Get.find<GetAllCategoriesUseCase>(),
        Get.find<GetTasksByCategoryUseCase>(),
        Get.find<UpdateTaskDoneUsecase>(),
        Get.find<DeleteTaskUseCase>(),
      ),
    );
  }
}
