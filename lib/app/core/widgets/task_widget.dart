import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:miplanner_v2/app/core/services/settings_service.dart';
import 'package:miplanner_v2/app/data/dto/task_dto.dart';

class TaskWidget extends StatelessWidget {
  final TaskDto dto;
  final Color? categoryColor;
  final VoidCallback onToggleDone;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const TaskWidget({
    super.key,
    required this.dto,
    required this.onToggleDone,
    required this.onDelete,
    required this.onTap,
    this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Slidable(
      key: ValueKey(dto.model.id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: colors.error,
            foregroundColor: colors.onError,
            icon: Icons.delete_rounded,
            label: 'delete'.tr,
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Obx(
                () => Checkbox(
                  value: dto.isDoneObs.value,
                  onChanged: (_) => onToggleDone(),
                  shape: const CircleBorder(),
                ),
              ),

              const SizedBox(width: 4),

              if (categoryColor != null) ...[
                Container(
                  width: 4,
                  height: 36,
                  decoration: BoxDecoration(
                    color: categoryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
              ],

              Expanded(
                child: Obx(() {
                  final isDone = dto.isDoneObs.value;
                  final is24h = SettingsService.to.isTimeFormat24hObs.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dto.model.title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          decoration: isDone ? TextDecoration.lineThrough : null,
                          color: isDone
                              ? colors.onSurface.withValues(alpha: 0.4)
                              : null,
                        ),
                      ),
                      if (dto.model.dueDate != null)
                        Text(
                          _formatDateTime(
                            dto.model.dueDate!,
                            dto.model.dueTime,
                            is24h,
                          ),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: _isOverdue(dto.model.dueDate!, isDone)
                                ? colors.error
                                : colors.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime date, String? storedTime, bool is24h) {
    final datePart = DateFormat('dd MMM yyyy', 'es_MX').format(date);
    if (storedTime == null) return datePart;

    final reparsed = _parseStoredTime(storedTime);
    if (reparsed == null) return '$datePart  $storedTime';

    final hour = reparsed.hour;
    final minute = reparsed.minute.toString().padLeft(2, '0');
    String timePart;
    if (is24h) {
      timePart = '${hour.toString().padLeft(2, '0')}:$minute';
    } else {
      final period = hour < 12 ? 'AM' : 'PM';
      final h = hour % 12 == 0 ? 12 : hour % 12;
      timePart = '${h.toString().padLeft(2, '0')}:$minute $period';
    }
    return '$datePart  $timePart';
  }

  TimeOfDay? _parseStoredTime(String time) {
    try {
      final parts = time.split(':');
      int hour = int.parse(parts[0].trim());
      final minPart = parts[1].trim();
      int minute;
      if (minPart.contains(' ')) {
        final mp = minPart.split(' ');
        minute = int.parse(mp[0]);
        if (mp[1].toUpperCase() == 'PM' && hour < 12) hour += 12;
        if (mp[1].toUpperCase() == 'AM' && hour == 12) hour = 0;
      } else {
        minute = int.parse(minPart);
      }
      return TimeOfDay(hour: hour, minute: minute);
    } catch (_) {
      return null;
    }
  }

  bool _isOverdue(DateTime dueDate, bool isDone) {
    if (isDone) return false;
    return dueDate.isBefore(DateTime.now());
  }
}
