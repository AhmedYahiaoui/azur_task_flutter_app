import 'package:azur_tech_task_app/models/task.dart';
import 'package:azur_tech_task_app/provider/task_provider.dart';
import 'package:azur_tech_task_app/utils/tools.dart';
import 'package:azur_tech_task_app/views/widget/taskWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthlyView extends StatefulWidget {
  const MonthlyView({super.key});

  @override
  State<MonthlyView> createState() => _MonthlyViewState();
}

class _MonthlyViewState extends State<MonthlyView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Task> _tasksForSelectedDay = [];

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    _selectedDay = Provider.of<TaskProvider>(context).selectedDate;
    _focusedDay = _selectedDay ?? DateTime.now();
    final tasks = taskProvider.tasks;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          // Calendar Widget
          Container(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 12,
            ),
            child: TableCalendar<Task>(
              firstDay: DateTime(2000),
              lastDay: DateTime(2030),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  // Filter tasks for the selected day
                  _tasksForSelectedDay = tasks
                      .where((task) => isSameDay(task.createdDate, selectedDay))
                      .toList();
                });

                // For updating the the selectedDay in the Provider
                Provider.of<TaskProvider>(context, listen: false)
                    .updateSelectedDate(selectedDay);

                // Show BottomSheet with tasks
                if (_tasksForSelectedDay.isNotEmpty) {
                  _showTaskBottomSheet(context, _tasksForSelectedDay);
                }
                // Navigate to the DailyView
                else {}
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  // Show dots for tasks ending on this day
                  final taskCount = tasks
                      .where((task) => isSameDay(task.createdDate, day))
                      .length;

                  if (taskCount > 0) {
                    return Positioned(
                      bottom: 10,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          taskCount,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: isSameDay(day, _selectedDay)
                                  ? Colors.white
                                  : Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
              calendarStyle: calendarStyle,
              headerStyle: headerStyle,
            ),
          ),
        ],
      ),
    );
  }

  void _showTaskBottomSheet(BuildContext context, List<Task> tasks) {
    showModalBottomSheet(
      backgroundColor: Colors.grey.shade50,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(12),
          // margin: const EdgeInsets.all(12),
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskWdiget(
                task: task,
                displayFullInfo: false,
              );
            },
          ),
        );
      },
    );
  }
}
