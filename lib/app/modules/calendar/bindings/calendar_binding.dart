import 'package:get/get.dart';
import 'package:miplanner_v2/app/domain/usecases/delete_task_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_taskses_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/update_task_done_usecase.dart';
import 'package:miplanner_v2/app/modules/calendar/controllers/calendar_controller.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalendarController>(
      () => CalendarController(
        Get.find<GetAllTasksUseCase>(),
        Get.find<UpdateTaskDoneUsecase>(),
        Get.find<DeleteTaskUseCase>(),
      ),
    );
  }
}
