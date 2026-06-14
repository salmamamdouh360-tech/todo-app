import 'package:flutter/material.dart';
import 'package:todo_project/core/shared_widgets/custom_app_button.dart';
import 'package:todo_project/core/shared_widgets/custom_text.dart';
import 'package:todo_project/core/theme/app_colors.dart';
import 'package:todo_project/models/task_models.dart';
import 'package:todo_project/task_repository.dart';

abstract class CustomBtnSheet {
  static Future displayCustomBtnSheet(
    BuildContext context, {
    required TaskRepository repository, // ✅
  }) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: Colors.black.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      builder: (context) => StatefulBuilder(
        // ✅ عشان نحدث Date & Time
        builder: (context, setState) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
          ),
          width: 450,
          height: 400,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Column(
                children: [
                  // ── Title field ─────────────────────────────────────────
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bgDark,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 40,
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Checkbox(value: true, onChanged: null),
                          Expanded(
                            child: TextField(
                              controller: titleCtrl, // ✅
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Task title',
                                hintStyle: TextStyle(color: Colors.white38),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Description field ───────────────────────────────────
                  SizedBox(
                    width: 350,
                    child: TextField(
                      style: TextStyle(color: AppColors.bgCard),
                      controller: descCtrl, // ✅
                      cursorColor: AppColors.bgDark,
                      maxLines: 4,
                      decoration: InputDecoration(
                        fillColor: AppColors.bgDark.withOpacity(0.08),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "  Description",
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Date & Time ─────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      children: [
                        // Date
                        GestureDetector(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030),
                            );
                            if (picked != null) {
                              setState(() => selectedDate = picked); // ✅
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.bgDark,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 40,
                            width: 150,
                            child: Row(
                              children: [
                                const SizedBox(width: 5),
                                Icon(
                                  Icons.date_range,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                CustomText(
                                  text:
                                      '  ${selectedDate.day}/${selectedDate.month}', // ✅
                                  colorText: Colors.white.withOpacity(0.8),
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Spacer(),

                        // Time
                        GestureDetector(
                          onTap: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );
                            if (picked != null) {
                              setState(() => selectedTime = picked); // ✅
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.bgDark,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 40,
                            width: 150,
                            child: Row(
                              children: [
                                const SizedBox(width: 5),
                                Icon(
                                  Icons.timer,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                CustomText(
                                  text:
                                      '  ${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}', // ✅
                                  colorText: Colors.white.withOpacity(0.8),
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Create / Cancel ─────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        // Create
                        // ── Create ──────────────────────────────────────────────────────
                        GestureDetector(
                          onTap: () async {
                            if (titleCtrl.text.trim().isEmpty) return;
                            {
                              await repository.addTask(
                                TaskModel(
                                  id: DateTime.now().millisecondsSinceEpoch
                                      .toString(),
                                  title: titleCtrl.text.trim(),
                                  description: descCtrl.text.trim(),
                                  date: selectedDate,
                                  time: selectedTime,
                                ),
                              );
                            }
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: CustomAppButton(
                            btnColor: const Color.fromARGB(255, 53, 146, 168),
                            child: CustomText(
                              text: "Create",
                              colorText: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),

                        const Spacer(),

                        // ── Cancel ──────────────────────────────────────────────────────
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: CustomAppButton(
                            btnColor: Colors.transparent,
                            borderColor: const Color.fromARGB(
                              255,
                              53,
                              146,
                              168,
                            ),
                            child: CustomText(
                              text: "Cancel",
                              colorText: const Color.fromARGB(
                                255,
                                0,
                                0,
                                0,
                              ).withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
