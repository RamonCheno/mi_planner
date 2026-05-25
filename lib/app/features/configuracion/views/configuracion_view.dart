import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miplanner_v2/app/features/configuracion/controllers/configuracion_controller.dart';

class ConfiguracionView extends GetView<ConfiguracionController> {
  const ConfiguracionView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentMode = AdaptiveTheme.of(context).mode;
    controller.onThemeChanged(currentMode);

    return Scaffold(
      appBar: AppBar(title: Text('settings_title'.tr)),
      body: ListView(
        children: [
          _SectionHeader(title: 'settings_appearance'.tr),
          Obx(
            () => SwitchListTile(
              secondary: const Icon(Icons.dark_mode_rounded),
              title: Text('settings_dark_mode'.tr),
              value: controller.isDarkMode.value,
              onChanged: (v) => controller.toggleTheme(v, context),
            ),
          ),

          const Divider(),

          _SectionHeader(title: 'settings_language'.tr),
          Obx(
            () => ListTile(
              leading: const Icon(Icons.language_rounded),
              title: Text('settings_language_label'.tr),
              trailing: DropdownButton<String>(
                value: controller.currentLocale.value,
                underline: const SizedBox.shrink(),
                items: const [
                  DropdownMenuItem(value: 'es_MX', child: Text('Español')),
                  DropdownMenuItem(value: 'en_US', child: Text('English')),
                ],
                onChanged: (v) {
                  if (v != null) controller.changeLocale(v);
                },
              ),
            ),
          ),

          const Divider(),

          _SectionHeader(title: 'settings_time_format'.tr),
          Obx(
            () => SwitchListTile(
              secondary: const Icon(Icons.access_time_rounded),
              title: Text('settings_time_24h'.tr),
              subtitle: Text(
                controller.isTimeFormat24h.value
                    ? 'settings_time_preview'.tr
                    : 'settings_time_preview12'.tr,
              ),
              value: controller.isTimeFormat24h.value,
              onChanged: controller.toggleTimeFormat,
            ),
          ),

          const Divider(),

          _SectionHeader(title: 'settings_notifications'.tr),
          Obx(
            () => ListTile(
              leading: const Icon(Icons.music_note_rounded),
              title: Text('settings_alarm_tone'.tr),
              subtitle: Text(
                controller.alarmSoundUri.value.isEmpty
                    ? 'settings_system_sound'.tr
                    : controller.alarmSoundUri.value.split('/').last,
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: controller.pickAlarmSound,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
