import 'package:posts_app/data/models/comment.dart';
import 'package:posts_app/services/api_service.dart';

class CommentService with ApiServiceMixin {
  Future<List<Comment>> getCommentsFromPost(int id) async {
    var mapData = await get("posts/$id/comments");
    return mapData.map((e) => Comment.fromMap(e)).toList();
  }
}
