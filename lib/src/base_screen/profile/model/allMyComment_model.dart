// To parse this JSON data, do
//
//     final allMyCommentModel = allMyCommentModelFromJson(jsonString);

import 'dart:convert';

AllMyCommentModel allMyCommentModelFromJson(String str) => AllMyCommentModel.fromJson(json.decode(str));

String allMyCommentModelToJson(AllMyCommentModel data) => json.encode(data.toJson());

class AllMyCommentModel {
  bool success;
  String description;
  Content content;

  AllMyCommentModel({
    required this.success,
    required this.description,
    required this.content,
  });

  factory AllMyCommentModel.fromJson(Map<String, dynamic> json) => AllMyCommentModel(
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
  Groups groups;

  Content({
    required this.groups,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    groups: Groups.fromJson(json["groups"]),
  );

  Map<String, dynamic> toJson() => {
    "groups": groups.toJson(),
  };
}

class Groups {
  int currentPage;
  List<DatumALlMyComments> data;
  String firstPageUrl;
  int? from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int? to;
  int total;

  Groups({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Groups.fromJson(Map<String, dynamic> json) => Groups(
    currentPage: json["current_page"],
    data: List<DatumALlMyComments>.from(json["data"].map((x) => DatumALlMyComments.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class DatumALlMyComments {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  String avatar;
  List<ImagePic> images;
  int totalMembers;
  List<Comment> comments;
  Pivot pivot;

  DatumALlMyComments({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
    required this.images,
    required this.totalMembers,
    required this.comments,
    required this.pivot,
  });

  factory DatumALlMyComments.fromJson(Map<String, dynamic> json) => DatumALlMyComments(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    avatar: json["avatar"],
    images: List<ImagePic>.from(json["images"].map((x) => ImagePic.fromJson(x))),
    totalMembers: json["total_members"],
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "avatar": avatar,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "total_members": totalMembers,
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    "pivot": pivot.toJson(),
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
  int laravelThroughKey;
  String? avatar;
  List<ImagePic> images;
  int likesCounter;
  int dislikesCounter;
  dynamic reactionType;
  int repliesCounter;

  Comment({
    required this.id,
    required this.body,
    required this.postId,
    required this.userId,
    this.parentCommentId,
    required this.createdAt,
    required this.updatedAt,
    required this.isAnonymous,
    required this.laravelThroughKey,
    this.avatar,
    required this.images,
    required this.likesCounter,
    required this.dislikesCounter,
    this.reactionType,
    required this.repliesCounter,
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
    laravelThroughKey: json["laravel_through_key"],
    avatar: json["avatar"],
    images: List<ImagePic>.from(json["images"].map((x) => ImagePic.fromJson(x))),
    likesCounter: json["likes_counter"],
    dislikesCounter: json["dislikes_counter"],
    reactionType: json["reaction_type"],
    repliesCounter: json["replies_counter"],
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
    "laravel_through_key": laravelThroughKey,
    "avatar": avatar,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "likes_counter": likesCounter,
    "dislikes_counter": dislikesCounter,
    "reaction_type": reactionType,
    "replies_counter": repliesCounter,
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

class Pivot {
  int userId;
  int groupId;

  Pivot({
    required this.userId,
    required this.groupId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    userId: json["user_id"],
    groupId: json["group_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "group_id": groupId,
  };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
