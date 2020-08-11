import 'package:flutter/foundation.dart';
import 'package:posts_app/data/database/database.dart';
import 'package:posts_app/data/models/comment.dart';
import 'package:posts_app/services/api_service_mixin.dart';

class CommentService with ApiServiceMixin {
  Future<List<Comment>> getCommentsForPost(int postId) async {
    var comments = await DbProvider.db.getCommentsFromPost(postId);
    if (comments.isNotEmpty) {
      print("Return comments from db");
      return comments;
    }
    return getCommentsForPostFromApi(postId: postId);
  }

  Future<List<Comment>> getCommentsForPostFromApi(
      {@required int postId, bool updateDatabase = true}) async {
    var mapData = await get("posts/$postId/comments");
    var comments = mapData.map((e) => Comment.fromMap(e)).toList();
    if (updateDatabase)
      comments.forEach((element) async {
        await _updateOrCreateComment(element);
      });

    print("Return comments from API");
    return comments;
  }

  Future<void> _updateOrCreateComment(Comment newComment) async {
    if (await DbProvider.db.getComment(newComment.id) == null) {
      await DbProvider.db.newComment(newComment);
    } else {
      await DbProvider.db.updateComment(newComment);
    }
  }
}
