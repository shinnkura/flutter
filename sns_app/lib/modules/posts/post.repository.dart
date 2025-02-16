import 'package:sns_app/modules/posts/post.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostRepository {
  Future<Post> create(String content, User user) async {
    final response = await Supabase.instance.client.from('post').insert({
      'content': content,
      'user_id': user.id,
    }).select();
    final post = response[0];
    return Post.fromJson({
      "id": post['id'],
      "content": post['content'],
      "user_id": post['user_id'],
      "user_name": user.userMetadata!['name'], // TODO:ここがNullになってる
    });
  }

  Future<List<Post>> find(int page, int limit) async {
    final start = (page - 1) * limit;
    final end = start + limit - 1;
    final posts = await Supabase.instance.client
        .from('posts_view')
        .select("*")
        .range(start, end)
        .order("created_at", ascending: false);
    return posts
        .map((post) => Post.fromJson({
              "id": post['id'],
              "content": post['content'],
              "user_id": post['user_id'],
              "user_name": post['user_metadata']['name'],
            }))
        .toList();
  }
}
