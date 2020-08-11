import 'package:posts_app/data/models/post.dart';
import 'package:posts_app/services/api_service.dart';

class PostService with ApiServiceMixin {
  Future<List<Post>> getPosts() async {
    var mapData = await get("posts");
    return mapData.map((e) => Post.fromMap(e)).toList();
  }
}
