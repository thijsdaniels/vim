import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String _email = 'thijsdaniels89@gmail.com';
  String _password = 'Welcome123!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: SimpleDialog(
        title: const Text('Welcome to Vim'),
        contentPadding: const EdgeInsets.all(16.0),
        children: [
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Email'),
            ),
            initialValue: _email,
            onChanged: (value) => setState(() {
              _email = value;
            }),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Password'),
            ),
            initialValue: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            onChanged: (value) => setState(() {
              _password = value;
            }),
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _email,
                  password: _password,
                );
              } on FirebaseAuthException catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error.message ?? error.code),
                  ),
                );
              }
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
