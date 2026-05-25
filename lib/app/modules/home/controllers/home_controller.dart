import 'package:get/get.dart';
import 'package:miplanner_v2/app/core/services/notification_service_fln.dart';
import 'package:miplanner_v2/app/core/services/permission_service.dart';
import 'package:miplanner_v2/app/modules/perfil/controllers/perfil_controller.dart';
import 'package:miplanner_v2/app/modules/tasks/screens/list_task/controllers/list_task_controller.dart';

class HomeController extends GetxController {
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await PermissionsService.to.requestNotificationPermission();
    await PermissionsService.to.requestExactAlarmPermission();
    await PermissionsService.to.requestIgnoreBatteryOptimizations();
    // TEST FLN: notificacion inmediata para verificar flutter_local_notifications.
    // Eliminar una vez confirmado el comportamiento.
    await NotificationServiceFln.to.showNow();
  }

  void onChangePage(int index) => currentIndex.value = index;

  void onTaskAdded() {
    try { Get.find<ListTaskController>().loadAll(); } catch (_) {}
    notifyTaskChanged();
  }

  void notifyTaskChanged() {
    try { Get.find<PerfilController>().loadStats(); } catch (_) {}
  }
}
