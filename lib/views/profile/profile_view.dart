import 'package:azur_tech_task_app/controllers/task_controller.dart';
import 'package:azur_tech_task_app/provider/task_provider.dart';
import 'package:azur_tech_task_app/provider/user_provider.dart';
import 'package:azur_tech_task_app/views/widget/taskTabsHeader.dart';
import 'package:azur_tech_task_app/views/widget/taskWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  final TaskController taskController;
  const ProfileView({super.key, required this.taskController});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final allTasks = taskProvider.tasks;
    final todayTasks = allTasks.where((task) {
      return task.createdDate.day == DateTime.now().day &&
          task.createdDate.month == DateTime.now().month &&
          task.createdDate.year == DateTime.now().year;
    }).toList();
    final favoriteTasks = allTasks.where((task) => task.isFavorit).toList();
    final notifyTasks = allTasks.where((task) => task.isNotify).toList();

    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    List filteredTasks;
    if (selectedFilter == 'All') {
      filteredTasks = allTasks;
    } else if (selectedFilter == 'Today') {
      filteredTasks = todayTasks;
    } else if (selectedFilter == 'Favorite') {
      filteredTasks = favoriteTasks;
    } else {
      filteredTasks = notifyTasks;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage:
                  user!.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
              child: user.photoUrl == null
                  ? const Icon(Icons.person, size: 40)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(user.name, style: const TextStyle(fontSize: 18)),
            Text(user.email, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final success =
                    await widget.taskController.syncTasksWithServer();
                final message = success
                    ? 'Tasks synced successfully!'
                    : 'Failed to sync tasks.';

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              },
              child: const Text('Sync Tasks'),
            ),
            const SizedBox(height: 20),
            TaskTabsHeader(
              allCount: allTasks.length,
              todayCount: todayTasks.length,
              favoriteCount: favoriteTasks.length,
              notifyCount: notifyTasks.length,
              onTabSelected: (tab) {
                setState(() {
                  selectedFilter = tab;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return TaskWdiget(
                    task: task,
                    displayFullInfo: false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
