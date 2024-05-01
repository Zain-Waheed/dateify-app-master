// To parse this JSON data, do
//
//     final singlePostModel = singlePostModelFromJson(jsonString);

import 'dart:convert';

SinglePostModel singlePostModelFromJson(String str) => SinglePostModel.fromJson(json.decode(str));

String singlePostModelToJson(SinglePostModel data) => json.encode(data.toJson());

class SinglePostModel {
  bool success;
  String description;
  Content content;

  SinglePostModel({
    required this.success,
    required this.description,
    required this.content,
  });

  factory SinglePostModel.fromJson(Map<String, dynamic> json) => SinglePostModel(
    success: json["success"],
    description: json["description"],
    content: Content.fromJson(json["content"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "description": description,
    "content": content.toJson(),
  };
}

class Content {
  Post post;

  Content({
    required this.post,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    post: Post.fromJson(json["post"]),
  );

  Map<String, dynamic> toJson() => {
    "post": post.toJson(),
  };
}

class Post {
  int id;
  int isFlag;
  int isAnonymous;
  int isApproved;
  String? flagDescription;
  int flagCount;
  String description;
  int userId;
  int groupId;
  String createdAt;
  DateTime updatedAt;
  String? avatar;
  List<ImagePic> images;
  int likesCounter;
  int dislikesCounter;
  dynamic reactionType;
  int commentsCount;
  List<Comment> comments;

  Post({
    required this.id,
    required this.isFlag,
    required this.isAnonymous,
    required this.isApproved,
    required this.flagDescription,
    required this.flagCount,
    required this.description,
    required this.userId,
    required this.groupId,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
    required this.images,
    required this.likesCounter,
    required this.dislikesCounter,
    this.reactionType,
    required this.commentsCount,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    isFlag: json["is_flag"],
    isAnonymous: json["is_anonymous"],
    isApproved: json["is_approved"],
    flagDescription: json["flag_description"],
    flagCount: json["flag_count"],
    description: json["description"],
    userId: json["user_id"],
    groupId: json["group_id"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
    avatar: json["avatar"],
    images: List<ImagePic>.from(json["images"].map((x) => ImagePic.fromJson(x))),
    likesCounter: json["likes_counter"],
    dislikesCounter: json["dislikes_counter"],
    reactionType: json["reaction_type"],
    commentsCount: json["comments_count"],
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_flag": isFlag,
    "is_anonymous": isAnonymous,
    "is_approved": isApproved,
    "flag_description": flagDescription,
    "flag_count": flagCount,
    "description": description,
    "user_id": userId,
    "group_id": groupId,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
    "avatar": avatar,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "likes_counter": likesCounter,
    "dislikes_counter": dislikesCounter,
    "reaction_type": reactionType,
    "comments_count": commentsCount,
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
  };
}

class Comment {
  int id;
  String body;
  int postId;
  int userId;
  int? parentCommentId;
  String createdAt;
  DateTime updatedAt;
  int isAnonymous;
  dynamic avatar;
  List<dynamic> images;
  int likesCounter;
  int dislikesCounter;
  dynamic reactionType;
  int repliesCounter;
  List<Comment>? childrenComments;

  Comment({
    required this.id,
    required this.body,
    required this.postId,
    required this.userId,
    this.parentCommentId,
    required this.createdAt,
    required this.updatedAt,
    required this.isAnonymous,
    this.avatar,
    required this.images,
    required this.likesCounter,
    required this.dislikesCounter,
    this.reactionType,
    required this.repliesCounter,
    this.childrenComments,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    body: json["body"],
    postId: json["post_id"],
    userId: json["user_id"],
    parentCommentId: json["parent_comment_id"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
    isAnonymous: json["is_anonymous"],
    avatar: json["avatar"],
    images: List<dynamic>.from(json["images"].map((x) => x)),
    likesCounter: json["likes_counter"],
    dislikesCounter: json["dislikes_counter"],
    reactionType: json["reaction_type"],
    repliesCounter: json["replies_counter"],
    childrenComments: json["children_comments"] == null ? [] : List<Comment>.from(json["children_comments"]!.map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "body": body,
    "post_id": postId,
    "user_id": userId,
    "parent_comment_id": parentCommentId,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
    "is_anonymous": isAnonymous,
    "avatar": avatar,
    "images": List<dynamic>.from(images.map((x) => x)),
    "likes_counter": likesCounter,
    "dislikes_counter": dislikesCounter,
    "reaction_type": reactionType,
    "replies_counter": repliesCounter,
    "children_comments": childrenComments == null ? [] : List<dynamic>.from(childrenComments!.map((x) => x.toJson())),
  };
}

class ImagePic {
  int id;
  String url;
  int order;

  ImagePic({
    required this.id,
    required this.url,
    required this.order,
  });

  factory ImagePic.fromJson(Map<String, dynamic> json) => ImagePic(
    id: json["id"],
    url: json["url"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "order": order,
  };
}
