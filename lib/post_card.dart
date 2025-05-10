import 'package:flutter/material.dart';
import 'package:flutter_5_wd/models/post_model.dart';

class PostCard extends StatelessWidget {
  const PostCard({required this.post, super.key});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card.outlined(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: colorScheme.onSurface.withValues(alpha: .1),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1746311473391-0c0bf08ad9b9?q=80&w=3570&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
                ),
                Expanded(
                  child: Text('${post.user?.getFullName()}'),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          Container(
            height: 320,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(post.url),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.comment_outlined)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.send)),
                    ],
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_add)),
              ],
            ),
          ),
          if (post.description != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                post.description!,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.outline,
                ),
              ),
            )
        ],
      ),
    );
  }
}
