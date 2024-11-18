import 'package:azur_tech_task_app/views/calendar/daily_view.dart';
import 'package:azur_tech_task_app/views/calendar/monthly_view.dart';
import 'package:flutter/material.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  bool _isMonthlyView = true;
  DateTime selectedDate = DateTime.now();

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      _isMonthlyView = false; // Switch to daily view
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        title: const Text("Calendar"),
      ),
      body: Column(
        children: [
          // Custom Switcher
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _changeView(true),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            _isMonthlyView ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Monthly",
                        style: TextStyle(
                          color: _isMonthlyView ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _changeView(false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            !_isMonthlyView ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Daily",
                        style: TextStyle(
                          color: !_isMonthlyView ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Main Content (Monthly/Daily View)
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isMonthlyView ? const MonthlyView() : const DailyView(),
            ),
          ),
        ],
      ),
    );
  }

  void _changeView(bool isMonthly) {
    setState(() {
      _isMonthlyView = isMonthly;
    });
  }
}
