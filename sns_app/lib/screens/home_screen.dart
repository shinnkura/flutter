import 'package:flutter/material.dart';
import 'package:sns_app/widgets/header.dart';
import 'package:sns_app/widgets/post_card.dart';
import 'package:sns_app/widgets/post_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Header(),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            PostInput(),
            PostCard(),
            PostCard(),
            PostCard(),
            PostCard(),
          ],
        ),
      ),
    );
  }
}
