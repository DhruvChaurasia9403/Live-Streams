// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? thumbnailImageUrl;
  String? platform;
  String? title;

  UserModel({
    this.id,
    this.thumbnailImageUrl,
    this.platform,
    this.title,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    thumbnailImageUrl: json["thumbnailImageUrl"],
    platform: json["platform"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "thumbnailImageUrl": thumbnailImageUrl,
    "platform": platform,
    "title": title,
  };
}
