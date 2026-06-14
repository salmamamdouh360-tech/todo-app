import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_project/core/shared_widgets/commo_widgets.dart';
import 'package:todo_project/core/theme/app_colors.dart';
import 'package:todo_project/models/task_Veiw.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({super.key, required this.viewModel});

  final TaskDetailViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: AppBackButton(),
        ),
        title: const Text('Task Details'),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (_, __) => _buildBody(context),
      ),
      bottomNavigationBar: AppBottomNav(currentIndex: 1, onTap: (_) {}),
    );
  }

  Widget _buildBody(BuildContext context) {
    final task = viewModel.task;
    final dateLabel = DateFormat('EEEE, d MMMM y').format(task.date);
    final timeLabel = _formatTime(task.time);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // ── Title row ────────────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.edit_outlined,
                  color: AppColors.textLight,
                  size: 20,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // ── Date & time meta ─────────────────────────────────────────────
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                color: AppColors.textMuted,
                size: 14,
              ),
              const SizedBox(width: 6),
              Text('Today', style: _metaStyle()),
              const SizedBox(width: 16),
              const Icon(
                Icons.access_time,
                color: AppColors.textMuted,
                size: 14,
              ),
              const SizedBox(width: 6),
              Text(timeLabel, style: _metaStyle()),
            ],
          ),

          const SizedBox(height: 18),
          const Divider(color: AppColors.bgCardLight, thickness: 1),
          const SizedBox(height: 18),

          // ── Description ──────────────────────────────────────────────────
          Expanded(
            child: Text(
              task.description.isNotEmpty
                  ? task.description
                  : 'No description provided for this task.',
              style: const TextStyle(
                color: AppColors.textLight,
                fontSize: 14,
                height: 1.75,
              ),
            ),
          ),

          // ── Action buttons ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TaskActionButton(
                  icon: Icons.check_circle_outline,
                  label: 'Done',
                  color: AppColors.accentGreen,
                  onTap: () async {
                    await viewModel.markDone();
                    if (context.mounted) Navigator.of(context).pop();
                  },
                ),
                TaskActionButton(
                  icon: Icons.delete_outline,
                  label: 'Delete',
                  color: AppColors.accentRed,
                  onTap: () async {
                    await viewModel.deleteTask();
                    if (context.mounted) Navigator.of(context).pop();
                  },
                ),
                TaskActionButton(
                  icon: Icons.push_pin_outlined,
                  label: 'Pin',
                  color: AppColors.accentOrange,
                  onTap: () => viewModel.togglePin(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _metaStyle() =>
      const TextStyle(color: AppColors.textMuted, fontSize: 13);

  String _formatTime(TimeOfDay t) {
    final hour = t.hour.toString().padLeft(2, '0');
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.hour >= 12 ? 'pm' : 'am';
    return '$hour:$minute$period';
  }
}
