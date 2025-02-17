import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_app/modules/auth/auth.repository.dart';
import 'package:sns_app/modules/auth/current_user.store.dart';
import 'package:sns_app/widgets/form_text_field.dart';
import 'package:sns_app/widgets/keyboard_aware.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends ConsumerState<SignupScreen> {
  String _userName = '';
  String _email = '';
  String _password = '';

  void _signup() async {
    final user = await AuthRepository().signup(_userName, _email, _password);
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
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      FormTextField(
                        label: 'Username',
                        hintText: 'Enter your username',
                        onChanged: (value) => setState(() => _userName = value),
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
                          onPressed: _userName.isNotEmpty &&
                                  _email.isNotEmpty &&
                                  _password.isNotEmpty
                              ? _signup
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
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
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
