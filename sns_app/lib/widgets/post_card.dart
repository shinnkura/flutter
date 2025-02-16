import 'package:flutter/material.dart';
import 'package:sns_app/modules/posts/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final void Function()? onDeleteButtonPressed;
  const PostCard({
    super.key,
    required this.post,
    required this.onDeleteButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: const Icon(
              Icons.person,
              size: 40,
            ),
            title: Text(
              post.userName,
              style: const TextStyle(
                color: Color(0xFF34D399),
              ),
            ),
            trailing: onDeleteButtonPressed != null
                ? TextButton(
                    onPressed: onDeleteButtonPressed,
                    child: const Text(
                      '削除',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              post.content,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
