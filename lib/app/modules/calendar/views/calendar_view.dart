import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miplanner_v2/app/core/widgets/task_widget.dart';
import 'package:miplanner_v2/app/modules/calendar/controllers/calendar_controller.dart';
import 'package:miplanner_v2/app/routes/app_pages.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends GetView<CalendarController> {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('calendar_title'.tr)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            TableCalendar(
              firstDay: DateTime(2020),
              lastDay: DateTime(2100),
              focusedDay: controller.focusedDay.value,
              selectedDayPredicate: (day) {
                final sel = controller.selectedDay.value;
                return sel != null && isSameDay(sel, day);
              },
              onDaySelected: controller.onDaySelected,
              onPageChanged: (focused) => controller.focusedDay.value = focused,
              eventLoader: controller.getEventsForDay,
              calendarStyle: CalendarStyle(
                markerDecoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
                todayDecoration: BoxDecoration(color: colors.primaryContainer, shape: BoxShape.circle),
                todayTextStyle: TextStyle(color: colors.onPrimaryContainer),
              ),
              headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
              locale: 'es_MX',
            ),

            const Divider(height: 1),

            Expanded(
              child: Obx(() {
                if (controller.dayTasks.isEmpty) {
                  return Center(
                    child: Text(
                      'calendar_no_tasks'.tr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.outline),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.dayTasks.length,
                  itemBuilder: (_, i) {
                    final dto = controller.dayTasks[i];
                    return TaskWidget(
                      dto: dto,
                      onToggleDone: () => controller.toggleDone(dto),
                      onDelete: () => controller.deleteTask(dto),
                      onTap: () async {
                        await Get.toNamed(Routes.updateTask, arguments: {'id': dto.model.id});
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
