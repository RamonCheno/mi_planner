import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miplanner_v2/app/core/widgets/task_widget.dart';
import 'package:miplanner_v2/app/modules/tasks/screens/list_task/controllers/list_task_controller.dart';
import 'package:miplanner_v2/app/routes/app_pages.dart';

class ListTaskScreen extends GetView<ListTaskController> {
  const ListTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('tasks_title'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: controller.loadAll,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: 12),
                Text(controller.errorMessage.value, textAlign: TextAlign.center),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: controller.loadAll,
                  child: Text('retry'.tr),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            if (controller.categories.isNotEmpty)
              SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Obx(
                        () => FilterChip(
                          label: Text('tasks_all'.tr),
                          selected: controller.selectedCategoryId.value == null,
                          onSelected: (_) => controller.filterByCategory(null),
                        ),
                      ),
                    ),
                    ...controller.categories.map(
                      (cat) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Obx(
                          () => FilterChip(
                            avatar: CircleAvatar(
                              backgroundColor: Color(cat.color),
                              radius: 8,
                            ),
                            label: Text(cat.name),
                            selected: controller.selectedCategoryId.value == cat.id,
                            onSelected: (_) => controller.filterByCategory(cat.id),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            Expanded(
              child: Obx(() {
                if (controller.tasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.checklist_rounded, size: 64, color: colors.outline),
                        const SizedBox(height: 12),
                        Text(
                          'tasks_empty'.tr,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: colors.outline),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.tasks.length,
                  itemBuilder: (_, i) {
                    final dto = controller.tasks[i];
                    final cat = controller.categoryOf(dto.model.categoryId);
                    return TaskWidget(
                      dto: dto,
                      categoryColor: cat != null ? Color(cat.color) : null,
                      onToggleDone: () => controller.toggleDone(dto),
                      onDelete: () => controller.deleteTask(dto),
                      onTap: () async {
                        await Get.toNamed(
                          Routes.updateTask,
                          arguments: {'id': dto.model.id},
                        );
                        controller.loadAll();
                      },
                    );
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
