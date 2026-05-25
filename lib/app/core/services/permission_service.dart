import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsService extends GetxService {
  static PermissionsService get to => Get.find<PermissionsService>();

  Future<bool> requestNotificationPermission() async {
    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (isAllowed) return true;
    return await AwesomeNotifications().requestPermissionToSendNotifications(
      permissions: [
        NotificationPermission.Alert,
        NotificationPermission.Sound,
        NotificationPermission.Badge,
        NotificationPermission.Vibration,
        NotificationPermission.Light,
        NotificationPermission.PreciseAlarms,
      ],
    );
  }

  Future<bool> checkNotificationPermission() async {
    return await AwesomeNotifications().isNotificationAllowed();
  }

  Future<bool> requestExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.request();
    return status.isGranted;
  }

  Future<bool> checkExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.status;
    return status.isGranted;
  }

  /// Solicita al SO que exima la app de la optimizacion de bateria (Doze mode).
  Future<bool> requestIgnoreBatteryOptimizations() async {
    final status = await Permission.ignoreBatteryOptimizations.request();
    return status.isGranted;
  }

  Future<bool> checkIgnoreBatteryOptimizations() async {
    final status = await Permission.ignoreBatteryOptimizations.status;
    return status.isGranted;
  }
}
