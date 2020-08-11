import 'package:flutter/material.dart';
import 'package:posts_app/commentspage.dart';
import 'package:posts_app/data/models/post.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final bool pressable;

  const PostItem({Key key, @required this.post, this.pressable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pressable
          ? () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => CommentsPage(
                        post: post,
                      )));
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              post.title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Text(
            post.body,
            style: TextStyle(color: Colors.black),
          ),
        ]),
      ),
    );
  }
}
