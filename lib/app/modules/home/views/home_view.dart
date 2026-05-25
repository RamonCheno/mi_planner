import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miplanner_v2/app/modules/calendar/views/calendar_view.dart';
import 'package:miplanner_v2/app/modules/home/controllers/home_controller.dart';
import 'package:miplanner_v2/app/modules/perfil/views/perfil_view.dart';
import 'package:miplanner_v2/app/modules/tasks/screens/list_task/views/list_task_screen.dart';
import 'package:miplanner_v2/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: const [ListTaskScreen(), CalendarView(), PerfilView()],
        ),
      ),
      floatingActionButton: Obx(() {
        if (controller.currentIndex.value != 0) {
          return const SizedBox.shrink();
        }
        return FloatingActionButton(
          heroTag: 'fab_add_task',
          onPressed: () async {
            await Get.toNamed(Routes.addTask);
            controller.onTaskAdded();
          },
          child: const Icon(Icons.add),
        );
      }),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.onChangePage,
          destinations: [
            NavigationDestination(icon: const Icon(Icons.checklist_rounded), label: 'nav_tasks'.tr),
            NavigationDestination(icon: const Icon(Icons.calendar_month_rounded), label: 'nav_calendar'.tr),
            NavigationDestination(icon: const Icon(Icons.person_rounded), label: 'nav_profile'.tr),
          ],
        ),
      ),
    );
  }
}
