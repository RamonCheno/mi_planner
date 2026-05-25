import 'package:get/get.dart';
import 'package:miplanner_v2/app/modules/tasks/controllers/tasks_controller.dart';

class TasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TasksController>(() => TasksController());
  }
}
