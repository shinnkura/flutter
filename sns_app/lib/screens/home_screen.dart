import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_app/modules/auth/current_user.store.dart';
import 'package:sns_app/modules/posts/post.dart';
import 'package:sns_app/modules/posts/post.repository.dart';
import 'package:sns_app/widgets/header.dart';
import 'package:sns_app/widgets/post_card.dart';
import 'package:sns_app/widgets/post_input.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  String _content = '';
  List<Post> _posts = [];
  final _textController = TextEditingController();
  final _limit = 10;
  int _page = 1;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initialize() {
    _fetchPosts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchPosts();
      }
    });
  }

  void _createPost() async {
    if (_content.isEmpty) return;
    final currentUser = ref.watch(currentUserProvider);
    final post = await PostRepository().create(_content, currentUser!);
    print(post);
    _textController.text = '';
    setState(() {
      _posts = [post, ..._posts]; // 新しい投稿を先頭に追加
      _content = '';
    });
  }

  void _fetchPosts() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    final postList = await PostRepository().find(_page, _limit);
    setState(() {
      _posts = [
        ..._posts,
        ...postList,
      ];
      _page++;
      _isLoading = false;
    });
  }

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
          controller: _scrollController,
          children: [
            PostInput(
              controller: _textController,
              content: _content,
              onChanged: (text) => setState(() => _content = text),
              onSubmitted: _createPost,
            ),
            ..._posts.map((post) => PostCard(post: post)),
          ],
        ),
      ),
    );
  }
}
