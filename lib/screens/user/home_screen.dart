import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_5_wd/models/post_model.dart';
import 'package:flutter_5_wd/providers/post_provider.dart';
import 'package:flutter_5_wd/services/api_service.dart';
import 'package:flutter_5_wd/widgets/post_card.dart';

import '../../providers/model_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> _posts = [];

  @override
  void initState() {
    super.initState();

    _loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 16,
        children: [
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(10, (int index) {
                return Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    spacing: 8,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1746311473391-0c0bf08ad9b9?q=80&w=3570&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      ),
                      Text(
                        'Story $index',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          ..._posts.mapIndexed((int index, post) {
            return PostCard(
              post: post,
            );
          })
        ],
      ),
    );
  }

  void _loadPosts() async {
    try {
      final DataList data = await PostProvider().getAll();

      if (!mounted) {
        return;
      }

      setState(() {
        _posts = data.rows.cast<PostModel>();
      });
    } on ApiException catch (e) {
      print(e.message);
    }
  }
}
