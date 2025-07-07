import 'package:flutter/material.dart';
import 'package:test/screens/second_screen.dart'; // Make sure this file exists

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  void _submit() {
    final enteredPassword = _passwordController.text.trim();

    if (enteredPassword == 'admin') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => const SecondScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wrong password man'),
          // backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appbar Title'),
      ),
      body: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
