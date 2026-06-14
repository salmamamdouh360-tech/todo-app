import 'dart:convert';

import 'package:flutter/material.dart';

enum TaskStatus { pending, done, pinned }

class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final TaskStatus status;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.status = TaskStatus.pending,
  });

  // ── Serialisation ─────────────────────────────────────────────────────────
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date.toIso8601String(),
    'timeHour': time.hour,
    'timeMinute': time.minute,
    'status': status.name,
  };

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String? ?? '',
    date: DateTime.parse(json['date'] as String),
    time: TimeOfDay(
      hour: json['timeHour'] as int,
      minute: json['timeMinute'] as int,
    ),
    status: TaskStatus.values.firstWhere(
      (s) => s.name == json['status'],
      orElse: () => TaskStatus.pending,
    ),
  );

  static List<TaskModel> listFromJson(String raw) {
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String listToJson(List<TaskModel> tasks) =>
      jsonEncode(tasks.map((t) => t.toJson()).toList());

  // ── Mutation ──────────────────────────────────────────────────────────────
  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    TimeOfDay? time,
    TaskStatus? status,
  }) => TaskModel(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    date: date ?? this.date,
    time: time ?? this.time,
    status: status ?? this.status,
  );

  bool get isDone => status == TaskStatus.done;
  bool get isPinned => status == TaskStatus.pinned;

  @override
  String toString() => 'Task($id, $title, ${date.toIso8601String()})';
}
