import 'package:azur_tech_task_app/controllers/services/auth_service.dart';
import 'package:azur_tech_task_app/controllers/services/notification_service.dart';
import 'package:azur_tech_task_app/controllers/services/task_service.dart';
import 'package:azur_tech_task_app/provider/task_provider.dart';
import 'package:azur_tech_task_app/provider/user_provider.dart';
import 'package:azur_tech_task_app/views/auth/sign_in_view.dart';
import 'package:azur_tech_task_app/views/auth/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();
  await NotificationService().requestIOSPermissions();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskProvider(TaskService()),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        Provider(
          create: (_) => AuthController(AuthService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Calendar',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        color: Colors.grey.shade50,
        initialRoute: '/',
        routes: {
          '/': (context) {
            final user = Provider.of<UserProvider>(context).user;
            if (user != null) {
              return const HomeView();
            } else {
              return SignInScreen(
                authController: AuthController(
                  AuthService(),
                ),
              );
            }
          },
          '/signup': (context) => SignUpScreen(
                authController: AuthController(
                  AuthService(),
                ),
              ),
          '/home': (context) => const HomeView(),
        },
      ),
    );
  }
}
