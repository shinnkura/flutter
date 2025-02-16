import 'package:flutter/material.dart';

class PostInput extends StatelessWidget {
  const PostInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade800),
        ),
      ),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: "What's on your mind?",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF34D399)),
              ),
            ),
            style: const TextStyle(color: Colors.black),
            maxLines: 3,
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(
                const Size(double.infinity, 40),
              ),
              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey;
                }
                return Colors.black;
              }),
            ),
            child: const Text(
              'Post',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
