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
            List<Post> posts;
            if (snapshot.hasData) posts = snapshot.data;
            return snapshot.hasData
                ? RefreshIndicator(
                    onRefresh: () async {},
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
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
