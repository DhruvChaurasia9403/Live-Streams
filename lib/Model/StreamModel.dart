class StreamModel {
  String? streamUrl;
  String? platform;
  String? title;
  String? thumbnailImageUrl;

  StreamModel({
    this.streamUrl,
    this.platform,
    this.title,
    this.thumbnailImageUrl,
  });

  factory StreamModel.fromJson(Map<String, dynamic> json) => StreamModel(
    streamUrl: json["streamUrl"],
    platform: json["platform"],
    title: json["title"],
    thumbnailImageUrl: json["thumbnailImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "streamUrl": streamUrl,
    "platform": platform,
    "title": title,
    "thumbnailImageUrl": thumbnailImageUrl,
  };
}