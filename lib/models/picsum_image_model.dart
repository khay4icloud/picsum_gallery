import 'package:json_annotation/json_annotation.dart';

part 'picsum_image_model.g.dart';

@JsonSerializable()
class PicsumImage {
  String id;
  String author;
  int width;
  int height;
  String url;

  @JsonKey(name: 'download_url')
  String downloadUrl;

  PicsumImage({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  factory PicsumImage.fromJson(Map<String, dynamic> json) =>
      _$PicsumImageFromJson(json);
  Map<String, dynamic> toJson() => _$PicsumImageToJson(this);
}
