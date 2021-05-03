import 'package:flutter/foundation.dart';

class ImgModel {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  ImgModel({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  factory ImgModel.fromJson(Map<String, dynamic> json) => ImgModel(
        albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl'],
      );
}
