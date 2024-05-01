// To parse this JSON data, do
//
//     final blockedListModel = blockedListModelFromJson(jsonString);

import 'dart:convert';

BlockedListModel blockedListModelFromJson(String str) => BlockedListModel.fromJson(json.decode(str));

String blockedListModelToJson(BlockedListModel data) => json.encode(data.toJson());

class BlockedListModel {
  bool success;
  String description;
  Content content;

  BlockedListModel({
    required this.success,
    required this.description,
    required this.content,
  });

  factory BlockedListModel.fromJson(Map<String, dynamic> json) => BlockedListModel(
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
  BlockList blockList;

  Content({
    required this.blockList,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    blockList: BlockList.fromJson(json["blockList"]),
  );

  Map<String, dynamic> toJson() => {
    "blockList": blockList.toJson(),
  };
}

class BlockList {
  int currentPage;
  List<DatumUserBlocked> data;
  String firstPageUrl;
  int from;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;

  BlockList({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
  });

  factory BlockList.fromJson(Map<String, dynamic> json) => BlockList(
    currentPage: json["current_page"],
    data: List<DatumUserBlocked>.from(json["data"].map((x) => DatumUserBlocked.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
  };
}

class DatumUserBlocked {
  int id;
  String name;
  String username;
  String gender;
  DateTime dob;
  String phone;
  int idVerified;
  DateTime createdAt;
  DateTime updatedAt;
  String blockedAt;
  String firstImage;
  String avatar;
  String large;
  String blurredAvatar;

  DatumUserBlocked({
    required this.id,
    required this.name,
    required this.username,
    required this.gender,
    required this.dob,
    required this.phone,
    required this.idVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.blockedAt,
    required this.firstImage,
    required this.avatar,
    required this.large,
    required this.blurredAvatar,
  });

  factory DatumUserBlocked.fromJson(Map<String, dynamic> json) => DatumUserBlocked(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    gender: json["gender"],
    dob: DateTime.parse(json["dob"]),
    phone: json["phone"],
    idVerified: json["id_verified"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    blockedAt: json["blocked_at"],
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
    "blocked_at": blockedAt,
    "firstImage": firstImage,
    "avatar": avatar,
    "large": large,
    "blurred_avatar": blurredAvatar,
  };
}
