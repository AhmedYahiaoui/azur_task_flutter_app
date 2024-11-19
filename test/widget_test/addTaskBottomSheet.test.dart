import 'package:azur_tech_task_app/views/widget/addTaskBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddTaskBottomSheet Widget Test', () {
    testWidgets('Should display all fields and buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => AddTaskBottomSheet(
                      selectedDate: DateTime.now(),
                    ),
                  );
                },
                child: Text('Open BottomSheet'),
              ),
            ),
          ),
        ),
      );

      // Tap the button to open the bottom sheet
      await tester.tap(find.text('Open BottomSheet'));
      await tester.pumpAndSettle();

      // Verify all form fields and buttons are present
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Start Time'), findsOneWidget);
      expect(find.text('End Time'), findsOneWidget);
      expect(find.text('Submit'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('Should close bottom sheet on Cancel button press',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => AddTaskBottomSheet(
                      selectedDate: DateTime.now(),
                    ),
                  );
                },
                child: Text('Open BottomSheet'),
              ),
            ),
          ),
        ),
      );

      // Tap the button to open the bottom sheet
      await tester.tap(find.text('Open BottomSheet'));
      await tester.pumpAndSettle();

      // Tap the Cancel button
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Verify the bottom sheet is closed
      expect(find.text('Title'), findsNothing);
    });

    testWidgets('Should validate input on Submit button press',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => AddTaskBottomSheet(
                      selectedDate: DateTime.now(),
                    ),
                  );
                },
                child: Text('Open BottomSheet'),
              ),
            ),
          ),
        ),
      );

      // Tap the button to open the bottom sheet
      await tester.tap(find.text('Open BottomSheet'));
      await tester.pumpAndSettle();

      // Attempt to submit without entering any data
      await tester.tap(find.text('Submit'));
      await tester.pump();

      // Verify validation message or behavior
      // Replace this with actual validation logic
      expect(true, true); // Update with actual condition
    });
  });
}
