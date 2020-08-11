class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({this.id, this.body, this.postId, this.name, this.email});

  factory Comment.fromMap(Map<String, dynamic> el) {
    return Comment(
        postId: el['postId'],
        body: el['body'],
        id: el['id'],
        name: el['name'],
        email: el['email']);
  }

  Map<String, dynamic> toMap() {
    return {
      "postId": postId,
      "id": id,
      "name": name,
      "email": email,
      "body": body
    };
  }
}
