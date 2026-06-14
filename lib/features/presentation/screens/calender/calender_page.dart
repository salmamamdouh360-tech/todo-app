import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_project/core/shared_widgets/commo_widgets.dart';
import 'package:todo_project/core/theme/app_colors.dart';
import 'package:todo_project/features/data/calender_screen.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key, required this.viewModel});

  final CalendarViewModel viewModel;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarViewModel get _vm => widget.viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: AppBackButton(onPressed: () {}),
        ),
        title: const Text('Manage Your Time'),
      ),
      body: ListenableBuilder(
        listenable: _vm,
        builder: (_, __) => Column(
          children: [
            const SizedBox(height: 12),
            _buildCalendarCard(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  DateFormat('d MMMM y').format(_vm.selectedDate),
                  style: const TextStyle(
                    color: AppColors.textLight,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_vm.tasks.isNotEmpty) _buildTaskList(),
          ],
        ),
      ),
    );
  }

  // ── Calendar card ─────────────────────────────────────────────────────────
  Widget _buildCalendarCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        children: [
          _buildMonthHeader(),
          const SizedBox(height: 12),
          _buildDayLabels(),
          const SizedBox(height: 6),
          _buildDayGrid(),
        ],
      ),
    );
  }

  Widget _buildMonthHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: _vm.previousMonth,
          child: const Icon(
            Icons.chevron_left,
            color: AppColors.textLight,
            size: 22,
          ),
        ),
        Text(
          DateFormat('MMMM').format(_vm.focusedMonth),
          style: const TextStyle(
            color: AppColors.textWhite,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: _vm.nextMonth,
          child: const Icon(
            Icons.chevron_right,
            color: AppColors.textLight,
            size: 22,
          ),
        ),
      ],
    );
  }

  Widget _buildDayLabels() {
    const days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    return Row(
      children: days
          .map(
            (d) => Expanded(
              child: Center(
                child: Text(
                  d,
                  style: TextStyle(
                    color: (d == 'Sa' || d == 'Su')
                        ? AppColors.weekendText
                        : AppColors.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDayGrid() {
    final firstDay = DateTime(_vm.focusedMonth.year, _vm.focusedMonth.month, 1);
    final startOffset = (firstDay.weekday - 1) % 7;
    final daysInMonth = DateTime(
      _vm.focusedMonth.year,
      _vm.focusedMonth.month + 1,
      0,
    ).day;
    final daysInPrev = DateTime(
      _vm.focusedMonth.year,
      _vm.focusedMonth.month,
      0,
    ).day;
    final now = DateTime.now();

    final cells = <Widget>[];

    // Leading
    for (int i = startOffset - 1; i >= 0; i--) {
      cells.add(
        _DayCell(
          day: daysInPrev - i,
          isCurrentMonth: false,
          isToday: false,
          isSelected: false,
          hasTasks: false,
          weekIndex: 0,
          onTap: () {},
        ),
      );
    }

    // Current month
    for (int d = 1; d <= daysInMonth; d++) {
      final date = DateTime(_vm.focusedMonth.year, _vm.focusedMonth.month, d);
      cells.add(
        _DayCell(
          day: d,
          isCurrentMonth: true,
          isToday:
              date.year == now.year &&
              date.month == now.month &&
              date.day == now.day,
          isSelected:
              date.year == _vm.selectedDate.year &&
              date.month == _vm.selectedDate.month &&
              date.day == _vm.selectedDate.day,
          hasTasks: _vm.busyDates.contains(
            DateTime(date.year, date.month, date.day),
          ),
          weekIndex: ((startOffset + d - 1) ~/ 7) + 1,
          onTap: () => _vm.selectDate(date),
        ),
      );
    }

    // Trailing
    final remaining = (7 - cells.length % 7) % 7;
    for (int d = 1; d <= remaining; d++) {
      cells.add(
        _DayCell(
          day: d,
          isCurrentMonth: false,
          isToday: false,
          isSelected: false,
          hasTasks: false,
          weekIndex: 0,
          onTap: () {},
        ),
      );
    }

    // Rows
    final rows = <Widget>[];
    int weekNum = _weekOfYear(firstDay);
    for (int r = 0; r < cells.length ~/ 7; r++) {
      rows.add(
        Row(
          children: [
            SizedBox(
              width: 22,
              child: Text(
                '${weekNum + r}',
                style: const TextStyle(
                  color: AppColors.textDisabled,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ...cells.sublist(r * 7, r * 7 + 7).map((c) => Expanded(child: c)),
          ],
        ),
      );
    }

    return Column(children: rows);
  }

  int _weekOfYear(DateTime date) {
    final diff = date.difference(DateTime(date.year, 1, 1)).inDays;
    return (diff ~/ 7) + 1;
  }

  // ── Task list ─────────────────────────────────────────────────────────────
  Widget _buildTaskList() {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _vm.tasks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) {
          final task = _vm.tasks[i];
          return Container(
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              title: Text(
                task.title,
                style: TextStyle(
                  color: task.isDone
                      ? AppColors.textMuted
                      : AppColors.textLight,
                  decoration: task.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: AppColors.accentRed,
                  size: 20,
                ),
                onPressed: () => _vm.deleteTask(task.id),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Day cell ──────────────────────────────────────────────────────────────────
class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.isCurrentMonth,
    required this.isToday,
    required this.isSelected,
    required this.hasTasks,
    required this.weekIndex,
    required this.onTap,
  });

  final int day;
  final bool isCurrentMonth, isToday, isSelected, hasTasks;
  final int weekIndex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.transparent;
    Color textColor = isCurrentMonth
        ? AppColors.textLight
        : AppColors.textDisabled;

    if (isToday && !isSelected) {
      bgColor = AppColors.accentCyan;
      textColor = AppColors.bgDark;
    } else if (isSelected && !isToday) {
      bgColor = AppColors.bgCardLight;
      textColor = AppColors.textWhite;
    } else if (isSelected && isToday) {
      bgColor = AppColors.accentCyan;
      textColor = AppColors.bgDark;
    }

    return GestureDetector(
      onTap: isCurrentMonth ? onTap : null,
      child: Container(
        margin: const EdgeInsets.all(2),
        height: 32,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              '$day',
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: isToday || isSelected
                    ? FontWeight.w700
                    : FontWeight.w400,
              ),
            ),
            if (hasTasks && !isToday && !isSelected)
              Positioned(
                bottom: 3,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentCyan,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
