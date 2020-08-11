import 'package:flutter/material.dart';
import 'package:posts_app/commentspage.dart';
import 'package:posts_app/data/models/post.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => CommentsPage(
                  post: post,
                )));
      },
      child: ListTile(
        title: Text(post.title),
        subtitle: Text(post.body),
      ),
    );
  }
}
