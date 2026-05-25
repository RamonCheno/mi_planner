import 'package:get/get.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_categories_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_tasks_by_id_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/update_task_usecase.dart';
import 'package:miplanner_v2/app/modules/tasks/screens/update_task/controllers/update_task_controller.dart';

class UpdateTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateTaskController>(
      () => UpdateTaskController(
        Get.find<GetTaskByIdUseCase>(),
        Get.find<UpdateTaskUseCase>(),
        Get.find<GetAllCategoriesUseCase>(),
      ),
    );
  }
}
