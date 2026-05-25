import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miplanner_v2/app/core/utils/app_logger.dart';

class NotificationService extends GetxService {
  static NotificationService get to => Get.find<NotificationService>();

  static const String _channelKey = 'miplanner_reminders';

  Future<NotificationService> init() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: _channelKey,
          channelName: 'Recordatorios',
          channelDescription: 'Notificaciones de tareas de MiPlanner',
          importance: NotificationImportance.Max,
          defaultPrivacy: NotificationPrivacy.Public,
          playSound: true,
          enableLights: true,
          enableVibration: true,
          defaultColor: Colors.deepPurple,
          ledColor: Colors.white,
        ),
      ],
      debug: true,
    );

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: _onActionReceived,
    );

    return this;
  }

  @pragma('vm:entry-point')
  static Future<void> _onActionReceived(ReceivedAction action) async {
    appLogger.log('[Notif] Notificacion id=${action.id} tocada por el usuario');
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    appLogger.log('[Notif] scheduleNotification | id=$id | title=$title | scheduledDate=$scheduledDate | ahora=${DateTime.now()}');

    if (scheduledDate.isBefore(DateTime.now())) {
      appLogger.warning('[Notif] ABORTADO — scheduledDate ya paso.');
      return;
    }

    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    appLogger.debug('[Notif] notificationsAllowed=$isAllowed');
    if (!isAllowed) {
      appLogger.warning('[Notif] ABORTADO — notificaciones no permitidas.');
      Get.snackbar(
        'Notificaciones desactivadas',
        'Activa los permisos de notificacion en Ajustes para recibir recordatorios.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade700,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    try {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: _channelKey,
          title: title,
          body: body,
          wakeUpScreen: true,
          category: NotificationCategory.Alarm,
          notificationLayout: NotificationLayout.Default,
        ),
        schedule: NotificationCalendar(
          year: scheduledDate.year,
          month: scheduledDate.month,
          day: scheduledDate.day,
          hour: scheduledDate.hour,
          minute: scheduledDate.minute,
          second: 0,
          millisecond: 0,
          allowWhileIdle: true,
          preciseAlarm: true,
          repeats: false,
        ),
      );
      appLogger.log('[Notif] PROGRAMADA — se disparara a las $scheduledDate');
    } catch (e, st) {
      appLogger.error('[Notif] ERROR al programar notificacion id=$id', e, st);
    }
  }

  /// Muestra una notificacion INMEDIATA (sin schedule) para verificar
  /// que el canal y los permisos funcionan correctamente.
  /// Llamar desde HomeController.onInit() solo para debugging.
  Future<void> showNow({String title = 'Test', String body = 'Notificacion inmediata'}) async {
    appLogger.log('[Notif] showNow — intentando notificacion inmediata');
    try {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 99999,
          channelKey: _channelKey,
          title: title,
          body: body,
          notificationLayout: NotificationLayout.Default,
        ),
      );
      appLogger.log('[Notif] showNow — OK');
    } catch (e, st) {
      appLogger.error('[Notif] showNow — ERROR', e, st);
    }
  }

  Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  Future<void> cancelAll() async {
    await AwesomeNotifications().cancelAll();
  }
}
