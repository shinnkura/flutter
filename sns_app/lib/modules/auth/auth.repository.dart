import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  Future<User?> signup(String name, String email, String password) async {
    final response = await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
      data: {"name": name},
    );
    return response.user;
  }

  Future<User?> signin(String email, String password) async {
    final response = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.user;
  }
}
