// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  bool success;
  String description;
  Content content;

  CommentModel({
    required this.success,
    required this.description,
    required this.content,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
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
  List<Comment> comments;

  Content({
    required this.comments,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
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
  String? avatar;
  List<ImagePicC> images;
  int likesCounter;
  int dislikesCounter;
  dynamic reactionType;
  UserC user;
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
    required this.user,
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
    images: List<ImagePicC>.from(json["images"].map((x) => ImagePicC.fromJson(x))),
    likesCounter: json["likes_counter"],
    dislikesCounter: json["dislikes_counter"],
    reactionType: json["reaction_type"],
    user: UserC.fromJson(json["user"]),
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
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "likes_counter": likesCounter,
    "dislikes_counter": dislikesCounter,
    "reaction_type": reactionType,
    "user": user.toJson(),
    "children_comments": childrenComments == null ? [] : List<dynamic>.from(childrenComments!.map((x) => x.toJson())),
  };
}

class ImagePicC {
  int id;
  String? url;
  File? filePath;
  int order;

  ImagePicC({
    required this.id,
     this.url,
    this.filePath,
    required this.order,
  });

  factory ImagePicC.fromJson(Map<String, dynamic> json) => ImagePicC(
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

class UserC {
  int id;
  String name;
  String username;
  String gender;
  DateTime dob;
  String phone;
  int idVerified;
  DateTime createdAt;
  DateTime updatedAt;
  String firstImage;
  String avatar;
  String large;
  String blurredAvatar;

  UserC({
    required this.id,
    required this.name,
    required this.username,
    required this.gender,
    required this.dob,
    required this.phone,
    required this.idVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.firstImage,
    required this.avatar,
    required this.large,
    required this.blurredAvatar,
  });

  factory UserC.fromJson(Map<String, dynamic> json) => UserC(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    gender: json["gender"],
    dob: DateTime.parse(json["dob"]),
    phone: json["phone"],
    idVerified: json["id_verified"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    firstImage: json["firstImage"],
    avatar: json["avatar"],
    large: json["large"],
    blurredAvatar: json["blurred_avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "gender": gender,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "phone": phone,
    "id_verified": idVerified,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "firstImage": firstImage,
    "avatar": avatar,
    "large": large,
    "blurred_avatar": blurredAvatar,
  };
}
