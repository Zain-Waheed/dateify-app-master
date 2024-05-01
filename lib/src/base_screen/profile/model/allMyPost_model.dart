// To parse this JSON data, do
//
//     final allMyPostsModel = allMyPostsModelFromJson(jsonString);

import 'dart:convert';

AllMyPostsModel allMyPostsModelFromJson(String str) => AllMyPostsModel.fromJson(json.decode(str));

String allMyPostsModelToJson(AllMyPostsModel data) => json.encode(data.toJson());

class AllMyPostsModel {
  bool success;
  String description;
  Content content;

  AllMyPostsModel({
    required this.success,
    required this.description,
    required this.content,
  });

  factory AllMyPostsModel.fromJson(Map<String, dynamic> json) => AllMyPostsModel(
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
  List<DatumAllMyPosts> data;
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
    data: List<DatumAllMyPosts>.from(json["data"].map((x) => DatumAllMyPosts.fromJson(x))),
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

class DatumAllMyPosts {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  String avatar;
  List<ImagePic> images;
  int totalMembers;
  bool isMember;
  List<Post> posts;
  Pivot pivot;

  DatumAllMyPosts({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
    required this.images,
    required this.totalMembers,
    required this.isMember,
    required this.posts,
    required this.pivot,
  });

  factory DatumAllMyPosts.fromJson(Map<String, dynamic> json) => DatumAllMyPosts(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    avatar: json["avatar"],
    images: List<ImagePic>.from(json["images"].map((x) => ImagePic.fromJson(x))),
    totalMembers: json["total_members"],
    isMember: json["is_member"],
    posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
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
    "is_member": isMember,
    "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
    "pivot": pivot.toJson(),
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
  String? reactionType;
  int commentsCount;
  List<Comment> comments;

  Post({
    required this.id,
    required this.isFlag,
    required this.isAnonymous,
    required this.isApproved,
    this.flagDescription,
    required this.flagCount,
    required this.description,
    required this.userId,
    required this.groupId,
    required this.createdAt,
    required this.updatedAt,
    this.avatar,
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
    "created_at": createdAtValues.reverse[createdAt],
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

enum CreatedAt { THE_1_WEEK_AGO, THE_6_DAYS_AGO, THE_2_DAYS_AGO, THE_16_HOURS_AGO }

final createdAtValues = EnumValues({
  "16 hours ago": CreatedAt.THE_16_HOURS_AGO,
  "1 week ago": CreatedAt.THE_1_WEEK_AGO,
  "2 days ago": CreatedAt.THE_2_DAYS_AGO,
  "6 days ago": CreatedAt.THE_6_DAYS_AGO
});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
