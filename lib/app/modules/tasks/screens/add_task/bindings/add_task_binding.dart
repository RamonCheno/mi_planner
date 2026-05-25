import 'package:get/get.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_categories_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/save_task_usecase.dart';
import 'package:miplanner_v2/app/modules/tasks/screens/add_task/controllers/add_task_controller.dart';

class AddTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTaskController>(
      () => AddTaskController(Get.find<SaveTaskUsecase>(), Get.find<GetAllCategoriesUseCase>()),
    );
  }
}
