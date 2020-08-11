import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:posts_app/data/models/comment.dart';
import 'package:posts_app/data/models/post.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static const postsTable = "Posts";
  static const commentsTable = "Comments";

  DbProvider._();
  static final db = DbProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<void> newPost(Post post) async {
    final db = await database;
    await db.rawInsert(
        "INSERT Into $postsTable (id,userId,title,body)"
        " VALUES (?,?,?,?)",
        [post.id, post.userId, post.title, post.body]);
  }

  Future<void> updatePost(Post newPost) async {
    final db = await database;
    await db.update("$postsTable", newPost.toMap(),
        where: "id = ?", whereArgs: [newPost.id]);
  }

  Future<Post> getPost(int id) async {
    final db = await database;
    var res = await db.query("$postsTable", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Post.fromMap(res.first) : null;
  }

  Future<void> newComment(Comment comment) async {
    final db = await database;
    await db.rawInsert(
        "INSERT Into $commentsTable (id,postId,name,email,body)"
        " VALUES (?,?,?,?,?)",
        [
          comment.id,
          comment.postId,
          comment.name,
          comment.email,
          comment.body
        ]);
  }

  Future<void> updateComment(Comment newComment) async {
    final db = await database;
    await db.update("$commentsTable", newComment.toMap(),
        where: "id = ?", whereArgs: [newComment.id]);
  }

  Future<Comment> getComment(int id) async {
    final db = await database;
    var res =
        await db.query("$commentsTable", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Comment.fromMap(res.first) : null;
  }

  Future<List<Post>> getPosts() async {
    final db = await database;
    var res = await db.query("$postsTable");

    List<Post> list =
        res.isNotEmpty ? res.map((c) => Post.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Comment>> getCommentsFromPost(int id) async {
    final db = await database;
    var res =
        await db.query("$commentsTable", where: "postId = ? ", whereArgs: [id]);

    List<Comment> list =
        res.isNotEmpty ? res.map((c) => Comment.fromMap(c)).toList() : [];
    return list;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "PostsApp.db");
    return await openDatabase(path, version: 1, onOpen: (Database db) async {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $postsTable ("
          "id INTEGER PRIMARY KEY,"
          "userId INTEGER,"
          "title TEXT,"
          "body TEXT"
          "); ");
      await db.execute("CREATE TABLE $commentsTable ("
          "id INTEGER PRIMARY KEY,"
          "postId INTEGER,"
          "name TEXT,"
          "email TEXT,"
          "body TEXT"
          ");");
    });
  }
}
