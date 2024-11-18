import 'package:azur_tech_task_app/controllers/auth_controller.dart';
import 'package:azur_tech_task_app/models/user.dart';
import 'package:azur_tech_task_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  final AuthController authController;

  const SignInScreen({super.key, required this.authController});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void _signIn() async {
    setState(() {
      _isLoading = true;
    });

    final result = await widget.authController.signIn(
      _emailController.text,
      _passwordController.text,
    );

    if (result && mounted) {
      // Update user in state
      final User user = widget.authController.user!;
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _signIn,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Sign In'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Don’t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
