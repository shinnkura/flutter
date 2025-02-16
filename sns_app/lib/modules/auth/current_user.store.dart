import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final currentUserProvider =
    StateNotifierProvider<CurrentUserStore, User?>((ref) {
  return CurrentUserStore(ref);
});

// グローバルステートの定義
class CurrentUserStore extends StateNotifier<User?> {
  CurrentUserStore(this.ref) : super(null);
  final Ref ref;

  void setCurrentUser(User? user) {
    state = user;
  }
}
