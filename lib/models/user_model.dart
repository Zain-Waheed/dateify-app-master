// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.success,
    required this.description,
    required this.content,
  });

  bool success;
  String description;
  Content content;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
  Content({
    required this.user,
  });

  User user;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
  };
}

class User {
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
    required this.images,
  });

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
  List<ImagePic> images;

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
    images: List<ImagePic>.from(json["images"].map((x) => ImagePic.fromJson(x))),
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
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };
}

class ImagePic {
  ImagePic({
    required this.id,
    required this.url,
    required this.order,
  });

  int id;
  String url;
  int order;

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
