import 'package:flutter/material.dart';
import 'package:flutter_5_wd/providers/post_provider.dart';
import 'package:flutter_5_wd/widgets/Smart_table.dart';

class AdminPostsScreen extends StatefulWidget {
  const AdminPostsScreen({super.key});

  @override
  State<AdminPostsScreen> createState() => _AdminPostsScreenState();
}

class _AdminPostsScreenState extends State<AdminPostsScreen> {
  @override
  Widget build(BuildContext context) {
    return SmartTable<PostProvider>(
      provider: PostProvider(),
      title: 'Posts',
    );
  }
}
