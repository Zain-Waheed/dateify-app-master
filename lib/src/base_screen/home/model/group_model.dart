
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

GroupModel groupModelFromJson(String str) => GroupModel.fromJson(json.decode(str));

String groupModelToJson(GroupModel data) => json.encode(data.toJson());

class GroupModel {
  bool success;
  String description;
  Content content;

  GroupModel({
    required this.success,
    required this.description,
    required this.content,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
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
  List<DatumGroups> data;
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
    data: List<DatumGroups>.from(json["data"].map((x) => DatumGroups.fromJson(x))),
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

class DatumGroups {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  String avatar;
  List<ImagePic> images;
  int totalMembers;
  Pivot pivot;

  DatumGroups({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
    required this.images,
    required this.totalMembers,
    required this.pivot,
  });

  factory DatumGroups.fromJson(Map<String, dynamic> json) => DatumGroups(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    avatar: json["avatar"],
    images: List<ImagePic>.from(json["images"].map((x) => ImagePic.fromJson(x))),
    totalMembers: json["total_members"],
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
