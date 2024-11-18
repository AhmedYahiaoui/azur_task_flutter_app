// ignore_for_file: file_names

import 'package:azur_tech_task_app/models/task.dart';
import 'package:azur_tech_task_app/provider/task_provider.dart';
import 'package:azur_tech_task_app/provider/user_provider.dart';
import 'package:azur_tech_task_app/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class AddTaskBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  const AddTaskBottomSheet({super.key, required this.selectedDate});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  // Task details
  String _title = '';
  String? _description;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  bool _isNotify = false;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context).user;
    DateTime createdDate = widget.selectedDate;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Gray line at the top
          Container(
            width: 100,
            height: 4,
            margin: const EdgeInsets.only(top: 10, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const Text(
            'New Task',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            width: MediaQuery.sizeOf(context).width * .8,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          // Form for task details
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title label
                  const Text(
                    'Title Task',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Title',
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    onSaved: (value) => _title = value!,
                  ),

                  const SizedBox(height: 20),

                  // Description label and field
                  const Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 6,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: 'Add Description ...',
                    ),
                    onSaved: (value) => _description = value,
                  ),

                  const SizedBox(height: 20),

                  // Start Time field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Time label and  field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            'Start time',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5, left: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextButton.icon(
                              onPressed: () async {
                                final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());
                                if (time != null) {
                                  setState(() => _startTime = time);
                                }
                              },
                              icon: const Icon(
                                Icons.access_time,
                                color: Colors.black,
                              ),
                              label: Text(
                                _startTime != null
                                    ? _startTime!.format(context)
                                    : 'Start Time',
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // End Time field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'End time',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5, right: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextButton.icon(
                              onPressed: () async {
                                final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());
                                if (time != null)
                                  setState(() => _endTime = time);
                              },
                              icon: const Icon(
                                Icons.access_time,
                                color: Colors.black,
                              ),
                              label: Text(
                                _endTime != null
                                    ? _endTime!.format(context)
                                    : 'End Time',
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Notification switch
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Notify Me'),
                      Switch(
                        activeColor: Colors.blue,
                        value: _isNotify,
                        onChanged: (value) => setState(() => _isNotify = value),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  // Buttons: Submit and Cancel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Cancel Button
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blueAccent),
                            color: Colors.white,
                          ),
                          height: 60,
                          width: MediaQuery.of(context).size.width * .43,
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: const Center(
                                child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.blueAccent,
                              ),
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Submit Button
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();

                            Random random = Random();
                            int randomNumber = random.nextInt(139495);
                            // Create new task and add it to provider
                            final newTask = Task(
                              id: DateTime.now().toIso8601String(),
                              userId: user!.id,
                              title: _title,
                              description: _description ?? '',
                              createdDate: createdDate,
                              startTime: createdDate.applied(
                                _startTime ?? TimeOfDay.now(),
                              ), // converting the TimeOfDay to DateTime
                              endTime: createdDate.applied(
                                _endTime ?? TimeOfDay.now(),
                              ),
                              isFavorit: false,
                              isNotify: _isNotify,
                              hash: randomNumber,
                            );
                            taskProvider.addTask(newTask);
                            Navigator.pop(context); // Close the bottom sheet
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            // border: Border.all(color: Colors.blueAccent),
                            color: Colors.blueAccent,
                          ),
                          height: 60,
                          width: MediaQuery.of(context).size.width * .43,
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: const Center(
                                child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
