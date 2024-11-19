import 'package:azur_tech_task_app/models/task.dart';
import 'package:azur_tech_task_app/provider/task_provider.dart';
import 'package:azur_tech_task_app/utils/tools.dart';
import 'package:azur_tech_task_app/views/widget/addTaskBottomSheet.dart';
import 'package:azur_tech_task_app/views/widget/taskWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DailyView extends StatefulWidget {
  const DailyView({super.key});

  @override
  State<DailyView> createState() => _DailyViewState();
}

class _DailyViewState extends State<DailyView> {
  DateTime _focusedDay = DateTime.now();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    selectedDate = Provider.of<TaskProvider>(context).selectedDate;
    _focusedDay = selectedDate;
    final filteredTasks = taskProvider.getTasksByDate(selectedDate);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          // One-week calendar view
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
              calendarFormat: CalendarFormat.week, // Only one week displayed
              selectedDayPredicate: (day) => isSameDay(selectedDate, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
                Provider.of<TaskProvider>(context, listen: false)
                    .updateSelectedDate(selectedDay);
              },
              calendarStyle: calendarStyle,
              headerStyle: headerStyle,
            ),
          ),

          // List of tasks for the selected day
          Expanded(
            child: filteredTasks.isEmpty
                ? const Center(
                    child: Text("No tasks for the selected day."),
                  )
                : ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return TaskWdiget(task: task);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showModernBottomSheet(context, selectedDate);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void showModernBottomSheet(BuildContext context, DateTime selectedDate) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the bottom sheet to expand fully
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (_) => AddTaskBottomSheet(
        selectedDate: selectedDate,
      ),
    );
  }
}
