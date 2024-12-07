import 'package:streamstreak/Model/StreamModel.dart';

class UserModel {
  String? id;
  List<StreamModel>? streams;

  UserModel({
    this.id,
    this.streams,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    streams: json["streams"] != null
        ? List<StreamModel>.from(json["streams"].map((x) => StreamModel.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "streams": streams != null
        ? List<dynamic>.from(streams!.map((x) => x.toJson()))
        : [],
  };
}