import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:miplanner_v2/app/modules/category/controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('categories_title'.tr)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await controller.showCategoryDialog();
          if (result != null) {
            await controller.createCategory(result.$1, result.$2);
          }
        },
        child: const Icon(Icons.add),
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
                Text(controller.errorMessage.value),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: controller.fetchAll,
                  child: Text('retry'.tr),
                ),
              ],
            ),
          );
        }

        if (controller.items.isEmpty) {
          return Center(
            child: Text('categories_empty'.tr, textAlign: TextAlign.center),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: controller.items.length,
          separatorBuilder: (context, x) => const Divider(height: 1, indent: 72),
          itemBuilder: (_, i) {
            final cat = controller.items[i];
            return Slidable(
              key: ValueKey(cat.id),
              endActionPane: ActionPane(
                motion: const DrawerMotion(),
                extentRatio: 0.25,
                children: [
                  SlidableAction(
                    onPressed: (_) async {
                      final confirmed = await Get.dialog<bool>(
                        AlertDialog(
                          title: Text('category_delete_title'.tr),
                          content: Text('confirm_delete'.trParams({'name': cat.name})),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(result: false),
                              child: Text('cancel'.tr),
                            ),
                            FilledButton(
                              onPressed: () => Get.back(result: true),
                              style: FilledButton.styleFrom(
                                backgroundColor: colors.error,
                                foregroundColor: colors.onError,
                              ),
                              child: Text('delete'.tr),
                            ),
                          ],
                        ),
                      );
                      if (confirmed == true) {
                        await controller.deleteCategory(cat.id);
                      }
                    },
                    backgroundColor: colors.error,
                    foregroundColor: colors.onError,
                    icon: Icons.delete_rounded,
                    label: 'delete'.tr,
                    borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(backgroundColor: Color(cat.color)),
                title: Text(cat.name),
                trailing: IconButton(
                  icon: const Icon(Icons.edit_rounded),
                  onPressed: () async {
                    final result = await controller.showCategoryDialog(editing: cat);
                    if (result != null) {
                      await controller.updateCategory(cat.copyWith(name: result.$1, color: result.$2));
                    }
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
