import 'package:get/get.dart';
import 'package:miplanner_v2/app/features/configuracion/controllers/configuracion_controller.dart';

class ConfiguracionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfiguracionController>(() => ConfiguracionController());
  }
}
