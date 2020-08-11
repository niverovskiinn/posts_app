import 'package:flutter/material.dart';
import 'package:posts_app/data/models/comment.dart';
import 'package:posts_app/data/models/post.dart';
import 'package:posts_app/services/comment_service.dart';
import 'package:posts_app/ui/widgets/post_item.dart';

class CommentsPage extends StatelessWidget {
  final Post post;
  const CommentsPage({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commentService = CommentService();
    return Scaffold(
        appBar: AppBar(
          title: Text("Post ${post.id}"),
        ),
        body: FutureBuilder<List<Comment>>(
            future: commentService.getCommentsForPost(post.id),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? CommentsList(post: post, comments: snapshot.data)
                  : Center(child: CircularProgressIndicator());
            }));
  }
}

class CommentsList extends StatefulWidget {
  final Post post;
  final List<Comment> comments;
  CommentsList({Key key, this.post, this.comments}) : super(key: key);

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  List<Comment> _comments;
  var _commentService = CommentService();

  @override
  Widget build(BuildContext context) {
    if (_comments == null) _comments = widget.comments;
    return RefreshIndicator(
      onRefresh: () async {
        _comments = await _commentService.getCommentsForPostFromApi(
            postId: widget.post.id + 1);
        setState(() {});
      },
      child: ListView(
        children: [
          PostItem(
            post: widget.post,
            pressable: false,
          ),
          ..._comments.map((e) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: CommentItem(
                  comment: e,
                ),
              ))
        ],
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final Comment comment;
  const CommentItem({Key key, @required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.name,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              comment.email,
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Text(comment.body)
        ],
      ),
    );
  }
}
