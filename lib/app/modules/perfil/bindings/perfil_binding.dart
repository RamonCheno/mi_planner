import 'package:get/get.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_taskses_usecase.dart';
import 'package:miplanner_v2/app/modules/perfil/controllers/perfil_controller.dart';

class PerfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerfilController>(
      () => PerfilController(Get.find<GetAllTasksUseCase>()),
    );
  }
}
