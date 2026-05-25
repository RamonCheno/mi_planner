import 'package:get/get.dart';
import 'package:miplanner_v2/app/core/services/notification_service.dart';
import 'package:miplanner_v2/app/core/services/notification_service_fln.dart';
import 'package:miplanner_v2/app/core/services/settings_service.dart';

Future<void> initAsyncServices() async {
  await Get.putAsync<SettingsService>(
    () => SettingsService().init(),
    permanent: true,
  );

  // Awesome Notifications — implementacion activa
  await Get.putAsync<NotificationService>(
    () => NotificationService().init(),
    permanent: true,
  );

  // flutter_local_notifications — implementacion paralela para comparar
  await Get.putAsync<NotificationServiceFln>(
    () => NotificationServiceFln().init(),
    permanent: true,
  );
}
