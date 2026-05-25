import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miplanner_v2/app/modules/perfil/controllers/perfil_controller.dart';
import 'package:miplanner_v2/app/routes/app_pages.dart';

class PerfilView extends GetView<PerfilController> {
  const PerfilView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('profile_title'.tr),
        actions: [
          IconButton(icon: const Icon(Icons.settings_rounded), onPressed: () => Get.toNamed(Routes.configuration)),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.loadStats,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('profile_progress'.tr, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: controller.completionRate,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(controller.completionRate * 100).toStringAsFixed(0)}%',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: [
                  _StatCard(
                    label: 'stat_total'.tr,
                    value: controller.totalTasks.value,
                    icon: Icons.list_alt_rounded,
                    color: colors.primary,
                  ),
                  _StatCard(
                    label: 'stat_done'.tr,
                    value: controller.doneTasks.value,
                    icon: Icons.check_circle_rounded,
                    color: Colors.green,
                  ),
                  _StatCard(
                    label: 'stat_pending'.tr,
                    value: controller.pendingTasks.value,
                    icon: Icons.radio_button_unchecked_rounded,
                    color: colors.secondary,
                  ),
                  _StatCard(
                    label: 'stat_overdue'.tr,
                    value: controller.overdueTasks.value,
                    icon: Icons.warning_amber_rounded,
                    color: colors.error,
                  ),
                ],
              ),

              if (controller.errorMessage.value.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  controller.errorMessage.value,
                  style: TextStyle(color: colors.error),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        );
      }),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color color;

  const _StatCard({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(value.toString(), style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: color)),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
