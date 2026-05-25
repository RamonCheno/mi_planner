import 'package:get/get.dart';
import 'package:miplanner_v2/app/data/providers/category_provider.dart';
import 'package:miplanner_v2/app/data/providers/tasks_provider.dart';
import 'package:miplanner_v2/app/data/repositories/category_repository_impl.dart';
import 'package:miplanner_v2/app/data/repositories/tasks_repository_impl.dart';
import 'package:miplanner_v2/app/domain/repositories/category_repository.dart';
import 'package:miplanner_v2/app/domain/repositories/tasks_repository.dart';
import 'package:miplanner_v2/app/domain/usecases/delete_task_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_taskses_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_tasks_by_id_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_tasks_by_category_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/save_task_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/update_task_done_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/update_task_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_categories_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_category_by_id_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/save_category_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/update_category_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/delete_category_usecase.dart';
import 'package:miplanner_v2/app/modules/calendar/controllers/calendar_controller.dart';
import 'package:miplanner_v2/app/modules/home/controllers/home_controller.dart';
import 'package:miplanner_v2/app/modules/perfil/controllers/perfil_controller.dart';
import 'package:miplanner_v2/app/modules/tasks/screens/list_task/controllers/list_task_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // fenix: true → si GetX descarta la instancia al salir de una sub-ruta,
    // se recrea automáticamente en el siguiente Get.find().
    Get.lazyPut<TaskProvider>(() => TaskProvider(), fenix: true);
    Get.lazyPut<CategoryProvider>(() => CategoryProvider(), fenix: true);

    Get.lazyPut<TaskRepository>(() => TaskRepositoryImpl(Get.find<TaskProvider>()), fenix: true);
    Get.lazyPut<CategoryRepository>(() => CategoryRepositoryImpl(Get.find<CategoryProvider>()), fenix: true);

    Get.lazyPut(() => GetAllTasksUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetTasksByCategoryUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetTaskByIdUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => SaveTaskUsecase(Get.find()), fenix: true);
    Get.lazyPut(() => UpdateTaskUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => UpdateTaskDoneUsecase(Get.find()), fenix: true);
    Get.lazyPut(() => DeleteTaskUseCase(Get.find()), fenix: true);

    Get.lazyPut(() => GetAllCategoriesUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetCategoryByIdUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => SaveCategoryUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => UpdateCategoryUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => DeleteCategoryUseCase(Get.find()), fenix: true);

    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<ListTaskController>(
      () => ListTaskController(Get.find(), Get.find(), Get.find(), Get.find(), Get.find()),
      fenix: true,
    );
    Get.lazyPut<CalendarController>(() => CalendarController(Get.find(), Get.find(), Get.find()), fenix: true);
    Get.lazyPut<PerfilController>(() => PerfilController(Get.find()), fenix: true);
  }
}
