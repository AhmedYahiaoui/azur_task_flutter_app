// ignore_for_file: file_names

import 'package:azur_tech_task_app/models/task.dart';
import 'package:azur_tech_task_app/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskWdiget extends StatelessWidget {
  final Task task;
  final bool displayFullInfo;
  const TaskWdiget(
      {super.key, required this.task, this.displayFullInfo = true});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        right: 20,
        left: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: task.startTime.isAfter(DateTime.now())
                        ? Colors.blue.shade100
                        : Colors.red.shade100,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  width: 8,
                  height: displayFullInfo ? 140 : 80,
                  child: const SizedBox(),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Text(
                                task.title,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    taskProvider.updateFavoritTask(
                                      id: task.id,
                                      isFavorit: !task.isFavorit,
                                    );
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: task.isFavorit
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                GestureDetector(
                                  onTap: () {
                                    // we cannot activate the notification for an old task (before now)
                                    if (task.startTime
                                        .isAfter(DateTime.now())) {
                                      taskProvider.updateNotificationTask(
                                        id: task.id,
                                        isNotify: !task.isNotify,
                                      );
                                    }
                                  },
                                  child: Icon(
                                    task.isNotify
                                        ? Icons.notifications_on_rounded
                                        : Icons.notifications_off_rounded,
                                    color: task.isNotify
                                        ? Colors.yellow
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (displayFullInfo) ...[
                          Text(
                            task.description,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 10),
                        ],
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade200,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.access_time, color: Colors.black),
                            const SizedBox(width: 5),
                            Text(
                                '${task.startTime.hour}:${task.startTime.minute}'),
                            const SizedBox(width: 10),
                            const Text('-'),
                            const SizedBox(width: 10),
                            const Icon(Icons.access_time, color: Colors.black),
                            const SizedBox(width: 5),
                            Text('${task.endTime.hour}:${task.endTime.minute}'),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
