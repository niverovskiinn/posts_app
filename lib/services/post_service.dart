import 'package:posts_app/data/database/database.dart';
import 'package:posts_app/data/models/post.dart';
import 'package:posts_app/services/api_service_mixin.dart';

class PostService with ApiServiceMixin {
  Future<List<Post>> getPosts() async {
    var posts = await DbProvider.db.getPosts();
    if (posts.isNotEmpty) {
      print("Return posts from db");
      return posts;
    }
    return getPostsFromApi();
  }

  Future<List<Post>> getPostsFromApi({bool updateDatabase = true}) async {
    var mapData = await get("posts");
    var posts = mapData.map((e) => Post.fromMap(e)).toList();
    if (updateDatabase)
      posts.forEach((element) async {
        await _updateOrCreatePost(element);
      });
    print("Return posts from API");
    return posts;
  }

  Future<void> _updateOrCreatePost(Post newPost) async {
    if (await DbProvider.db.getPost(newPost.id) == null) {
      await DbProvider.db.newPost(newPost);
    } else {
      await DbProvider.db.updatePost(newPost);
    }
  }
}
