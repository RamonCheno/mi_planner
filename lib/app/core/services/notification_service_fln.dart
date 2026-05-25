import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:miplanner_v2/app/core/utils/app_logger.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Implementacion de notificaciones usando flutter_local_notifications.
/// Clase paralela a NotificationService (awesome_notifications) para comparar
/// comportamiento en diferentes versiones de Android.
class NotificationServiceFln extends GetxService {
  static NotificationServiceFln get to => Get.find<NotificationServiceFln>();

  final _plugin = FlutterLocalNotificationsPlugin();

  static const String _channelId = 'miplanner_fln';
  static const String _channelName = 'MiPlanner FLN';

  Future<NotificationServiceFln> init() async {
    tz.initializeTimeZones();
    try {
      final tzInfo = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(tzInfo.identifier));
    } catch (_) {
      tz.setLocalLocation(tz.UTC);
    }

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    await _plugin.initialize(
      settings: const InitializationSettings(android: androidSettings),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        appLogger.log('[FLN] Notificacion id=${response.id} tocada por el usuario');
      },
    );

    await _createChannel();
    appLogger.log('[FLN] Servicio inicializado — TZ: ${tz.local.name}');
    return this;
  }

  Future<void> _createChannel() async {
    const channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: 'Notificaciones flutter_local_notifications',
      importance: Importance.max,
      playSound: true,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // ─── Test ────────────────────────────────────────────────────────────────

  /// Muestra una notificacion INMEDIATA para verificar canal y permisos.
  Future<void> showNow({
    String title = 'Test FLN',
    String body = 'Notificacion inmediata flutter_local_notifications',
  }) async {
    appLogger.log('[FLN] showNow — intentando notificacion inmediata');
    try {
      await _plugin.show(
        id: 99998,
        title: title,
        body: body,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            importance: Importance.max,
            priority: Priority.max,
          ),
        ),
      );
      appLogger.log('[FLN] showNow — OK');
    } catch (e, st) {
      appLogger.error('[FLN] showNow — ERROR', e, st);
    }
  }

  // ─── Schedule ────────────────────────────────────────────────────────────

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    appLogger.log('[FLN] scheduleNotification | id=$id | scheduledDate=$scheduledDate | ahora=${DateTime.now()}');

    if (scheduledDate.isBefore(DateTime.now())) {
      appLogger.warning('[FLN] ABORTADO — scheduledDate ya paso.');
      return;
    }

    final androidImpl = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    final notificationsEnabled = await androidImpl?.areNotificationsEnabled() ?? true;
    appLogger.debug('[FLN] notificationsEnabled=$notificationsEnabled');
    if (!notificationsEnabled) {
      appLogger.warning('[FLN] ABORTADO — POST_NOTIFICATIONS denegado.');
      Get.snackbar(
        'Notificaciones desactivadas',
        'Activa los permisos de notificacion en Ajustes.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade700,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    final canExact = await androidImpl?.canScheduleExactNotifications() ?? true;
    final scheduleMode = canExact ? AndroidScheduleMode.exactAllowWhileIdle : AndroidScheduleMode.inexactAllowWhileIdle;
    appLogger.debug('[FLN] canExactAlarm=$canExact | modo=${canExact ? "exact" : "inexact"}');

    try {
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            importance: Importance.max,
            priority: Priority.max,
            fullScreenIntent: true,
          ),
        ),
        androidScheduleMode: scheduleMode,
      );
      appLogger.log('[FLN] PROGRAMADA — se disparara a las $scheduledDate (TZ: ${tz.local.name})');
    } catch (e, st) {
      appLogger.error('[FLN] ERROR al programar id=$id', e, st);
    }
  }

  // ─── Cancel ──────────────────────────────────────────────────────────────

  Future<void> cancelNotification(int id) async => _plugin.cancel(id: id);

  Future<void> cancelAll() async => _plugin.cancelAll();
}
