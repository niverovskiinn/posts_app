import 'package:flutter/material.dart';
import 'package:posts_app/data/models/post.dart';
import 'package:posts_app/services/post_service.dart';
import 'package:posts_app/ui/widgets/post_item.dart';

class Homepage extends StatelessWidget {
  final String title;
  const Homepage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postService = PostService();
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder<List<Post>>(
          future: postService.getPosts(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? PostsList(posts: snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class PostsList extends StatefulWidget {
  final List<Post> posts;
  PostsList({Key key, @required this.posts}) : super(key: key);

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  List<Post> posts;
  var _postService = PostService();

  @override
  Widget build(BuildContext context) {
    if (posts == null) posts = widget.posts;
    return RefreshIndicator(
      onRefresh: () async {
        posts = await _postService.getPostsFromApi();
        setState(() {});
      },
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostItem(post: posts[index]),
              Divider(
                thickness: 2,
              )
            ],
          );
        },
      ),
    );
  }
}
