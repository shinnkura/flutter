import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sns_app/screens/home_screen.dart';
import 'package:sns_app/screens/signin_screen.dart';
import 'package:sns_app/screens/signup_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_API_KEY']!,
  );
  runApp(SnsApp());
}

class SnsApp extends StatefulWidget {
  const SnsApp({super.key});

  @override
  SnsAppState createState() => SnsAppState();
}

class SnsAppState extends State<SnsApp> {
  @override
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xff34d399),
        appBarTheme: AppBarTheme(
          color: Color(0xff34D399),
          elevation: 0,
        ),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          case '/signin':
            return MaterialPageRoute(
                builder: (context) => const SigninScreen());
          case '/signup':
            return MaterialPageRoute(
                builder: (context) => const SignupScreen());
          default:
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(
                  child: Text('404 Not Found'),
                ),
              ),
            );
        }
      },
      home: const SigninScreen(),
    );
  }
}
