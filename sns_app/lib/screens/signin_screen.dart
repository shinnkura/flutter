import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_app/modules/auth/auth.repository.dart';
import 'package:sns_app/modules/auth/current_user.store.dart';
import 'package:sns_app/widgets/form_text_field.dart';
import 'package:sns_app/widgets/keyboard_aware.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  SigninScreenState createState() => SigninScreenState();
}

class SigninScreenState extends ConsumerState<SigninScreen> {
  String _email = '';
  String _password = '';

  void _signin() async {
    final user = await AuthRepository().signin(_email, _password);
    ref.read(currentUserProvider.notifier).setCurrentUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'SNS APP',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: KeyboardAware(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      FormTextField(
                        label: 'Email',
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => setState(() => _email = value),
                      ),
                      const SizedBox(height: 16.0),
                      FormTextField(
                        label: 'Password',
                        hintText: 'Enter your password',
                        obscureText: true,
                        onChanged: (value) => setState(() => _password = value),
                      ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _email.isNotEmpty && _password.isNotEmpty
                              ? _signin
                              : null,
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(WidgetState.disabled)) {
                                return Colors.grey;
                              }
                              return Colors.black;
                            }),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                          textStyle: const TextStyle(
                              decoration: TextDecoration.underline),
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/signup'),
                        child: const Text("Sign Up"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
