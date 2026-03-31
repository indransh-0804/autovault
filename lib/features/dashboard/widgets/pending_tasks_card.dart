import 'package:autovault/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:autovault/data/models/task_model.dart';
import 'package:autovault/features/dashboard/providers/dashboard_provider.dart';

class PendingTasksCard extends ConsumerWidget {
  const PendingTasksCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final tasks = ref.watch(pendingTasksProvider);
    final completedCount = tasks.where((t) => t.isCompleted).length;

    return Container(
      padding: EdgeInsets.all(SizeConfig.w(16)),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(SizeConfig.w(12)),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Container(
                  padding: EdgeInsets.all(SizeConfig.w(8)),
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(SizeConfig.w(8)),
                  ),
                  child: Icon(Icons.checklist_rounded,
                      color: cs.primary, size: SizeConfig.w(16)),
                ),
                SizedBox(width: SizeConfig.w(8)),
                Text(
                  '$completedCount/${tasks.length} done',
                  style: tt.labelSmall?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
              SizedBox(
                width: SizeConfig.w(80),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(SizeConfig.w(4)),
                  child: LinearProgressIndicator(
                    value: tasks.isEmpty ? 0 : completedCount / tasks.length,
                    backgroundColor: cs.onSurface.withValues(alpha: 0.08),
                    valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
                    minHeight: SizeConfig.h(4),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.h(12)),
          ...tasks.map((task) => _TaskItem(task: task)),
        ],
      ),
    );
  }
}

class _TaskItem extends ConsumerWidget {
  final PendingTask task;
  const _TaskItem({required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.h(8)),
      child: InkWell(
        onTap: () =>
            ref.read(pendingTasksProvider.notifier).toggleTask(task.id),
        borderRadius: BorderRadius.circular(SizeConfig.w(8)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.w(8),
            vertical: SizeConfig.h(8),
          ),
          decoration: BoxDecoration(
            color: task.isCompleted
                ? cs.primary.withValues(alpha: 0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(SizeConfig.w(8)),
            border: Border.all(
              color: task.isCompleted
                  ? cs.primary.withValues(alpha: 0.15)
                  : cs.outlineVariant.withValues(alpha: 0.15),
            ),
          ),
          child: Row(children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: SizeConfig.w(20),
              height: SizeConfig.w(20),
              decoration: BoxDecoration(
                color: task.isCompleted ? cs.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(SizeConfig.w(4)),
                border: Border.all(
                  color: task.isCompleted
                      ? cs.primary
                      : cs.outline.withValues(alpha: 0.5),
                  width: 2,
                ),
              ),
              child: task.isCompleted
                  ? Icon(Icons.check_rounded,
                      size: SizeConfig.w(12), color: cs.surface)
                  : null,
            ),
            SizedBox(width: SizeConfig.w(12)),
            Expanded(
              child: Text(
                task.title,
                style: tt.bodySmall?.copyWith(
                  color: task.isCompleted ? cs.outline : cs.onSurface,
                  fontWeight: FontWeight.w500,
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                  decorationColor: cs.outline,
                ),
              ),
            ),
            SizedBox(width: SizeConfig.w(8)),
            Text(
              task.dueTime,
              style: tt.labelSmall?.copyWith(
                color: task.isCompleted
                    ? cs.outline.withValues(alpha: 0.5)
                    : cs.primary.withValues(alpha: 0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
