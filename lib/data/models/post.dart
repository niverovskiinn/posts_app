class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromMap(Map<String, dynamic> el) {
    return Post(
        userId: el['userId'],
        id: el['id'],
        title: el['title'],
        body: el['body']);
  }
}
