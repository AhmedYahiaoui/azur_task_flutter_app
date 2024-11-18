// ignore_for_file: file_names
import 'package:flutter/material.dart';

class TaskTabsHeader extends StatefulWidget {
  final int allCount;
  final int todayCount;
  final int favoriteCount;
  final int notifyCount;
  final Function(String) onTabSelected;

  const TaskTabsHeader({
    super.key,
    required this.allCount,
    required this.todayCount,
    required this.favoriteCount,
    required this.notifyCount,
    required this.onTabSelected,
  });

  @override
  State<TaskTabsHeader> createState() => _TaskTabsHeaderState();
}

class _TaskTabsHeaderState extends State<TaskTabsHeader> {
  String selectedTab = 'All';

  void selectTab(String tab) {
    setState(() {
      selectedTab = tab;
    });
    widget.onTabSelected(tab);
  }

  Widget buildTab(String label, int count) {
    final bool isSelected = label == selectedTab;

    return GestureDetector(
      onTap: () => selectTab(label),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 12,
            backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
            child: Text(
              count.toString(),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildTab('All', widget.allCount),
        const Text('|'),
        buildTab('Today', widget.todayCount),
        buildTab('Favorite', widget.favoriteCount),
        buildTab('Notify', widget.notifyCount),
      ],
    );
  }
}
