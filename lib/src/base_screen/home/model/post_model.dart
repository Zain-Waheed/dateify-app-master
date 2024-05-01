// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  bool success;
  String description;
  Content content;

  Welcome({
    required this.success,
    required this.description,
    required this.content,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
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
  Posts posts;

  Content({
    required this.posts,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    posts: Posts.fromJson(json["posts"]),
  );

  Map<String, dynamic> toJson() => {
    "posts": posts.toJson(),
  };
}

class Posts {
  int currentPage;
  List<Datum> data;
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

  Posts({
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

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  int id;
  int isFlag;
  int isAnonymous;
  int isApproved;
  String? flagDescription;
  int flagCount;
  String? description;
  int userId;
  int groupId;
  String createdAt;
  DateTime updatedAt;
  String? avatar;
  List<ImagePicP> images;
  int likesCounter;
  int dislikesCounter;
  dynamic reactionType;
  int commentsCount;
  User user;

  Datum({
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
    required this.user,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    images: List<ImagePicP>.from(json["images"].map((x) => ImagePicP.fromJson(x))),
    likesCounter: json["likes_counter"],
    dislikesCounter: json["dislikes_counter"],
    reactionType: json["reaction_type"],
    commentsCount: json["comments_count"],
    user: User.fromJson(json["user"]),
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
    "user": user.toJson(),
  };
}

class ImagePicP {
  int id;
  String url;
  int order;

  ImagePicP({
    required this.id,
    required this.url,
    required this.order,
  });

  factory ImagePicP.fromJson(Map<String, dynamic> json) => ImagePicP(
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

class User {
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

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
