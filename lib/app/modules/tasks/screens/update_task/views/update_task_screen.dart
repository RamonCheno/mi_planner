import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miplanner_v2/app/modules/tasks/screens/update_task/controllers/update_task_controller.dart';

class UpdateTaskScreen extends GetView<UpdateTaskController> {
  const UpdateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('tasks_edit_title'.tr)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return _buildForm(context);
      }),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: controller.titleCtrl,
            decoration: InputDecoration(
              labelText: 'task_title_label'.tr,
              border: const OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.sentences,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'task_title_required'.tr : null,
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: controller.descCtrl,
            decoration: InputDecoration(
              labelText: 'task_desc_label'.tr,
              border: const OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.sentences,
            maxLines: 3,
          ),
          const SizedBox(height: 16),

          Obx(() {
            final cats = controller.categories;
            if (cats.isEmpty) return const SizedBox.shrink();
            return DropdownButtonFormField<int?>(
              initialValue: controller.selectedCategoryId.value,
              decoration: InputDecoration(
                labelText: 'task_category_label'.tr,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem<int?>(
                  value: null,
                  child: Text('task_no_category'.tr),
                ),
                ...cats.map(
                  (c) => DropdownMenuItem<int?>(
                    value: c.id,
                    child: Row(
                      children: [
                        CircleAvatar(backgroundColor: Color(c.color), radius: 8),
                        const SizedBox(width: 8),
                        Text(c.name),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (v) => controller.selectedCategoryId.value = v,
            );
          }),
          const SizedBox(height: 16),

          Obx(
            () => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today_rounded),
              title: Text(
                controller.dueDate.value == null
                    ? 'task_date_label'.tr
                    : controller.formattedDate,
              ),
              trailing: controller.dueDate.value != null
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.dueDate.value = null;
                        controller.dueTime.value = null;
                      },
                    )
                  : null,
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: controller.dueDate.value ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) controller.dueDate.value = picked;
              },
            ),
          ),

          Obx(
            () => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.access_time_rounded),
              title: Text(
                controller.dueTime.value == null
                    ? 'task_time_label'.tr
                    : controller.formattedTime,
              ),
              trailing: controller.dueTime.value != null
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => controller.dueTime.value = null,
                    )
                  : null,
              enabled: controller.dueDate.value != null,
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: controller.dueTime.value ?? TimeOfDay.now(),
                );
                if (picked != null) controller.dueTime.value = picked;
              },
            ),
          ),

          const SizedBox(height: 24),

          FilledButton(
            onPressed: controller.save,
            child: Text('task_save_changes'.tr),
          ),

          Obx(() {
            if (controller.errorMessage.value.isEmpty) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                controller.errorMessage.value,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
                textAlign: TextAlign.center,
              ),
            );
          }),
        ],
      ),
    );
  }
}
