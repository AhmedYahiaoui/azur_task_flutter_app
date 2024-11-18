import 'package:azur_tech_task_app/provider/task_provider.dart';
import 'package:azur_tech_task_app/views/calendar/calendar_view.dart';
import 'package:azur_tech_task_app/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/task_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final taskController = TaskController(
      Provider.of<TaskProvider>(context, listen: false).service,
      Provider.of<TaskProvider>(context, listen: false),
    );

    final List<Widget> pages = [
      const CalendarView(),
      ProfileView(taskController: taskController),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      backgroundColor: Colors.grey.shade50,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.shade50,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
