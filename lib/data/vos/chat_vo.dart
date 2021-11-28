import 'package:json_annotation/json_annotation.dart';

part 'chat_vo.g.dart';

@JsonSerializable()
class ChatVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "text")
  String? text;

  @JsonKey(name: "image_url")
  String? imageUrl;

  @JsonKey(name: "video_url")
  String? videoUrl;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "created_date")
  String? createdDate;

  bool textWithFile;

  ChatVO({
    this.id,
    this.text,
    this.imageUrl,
    this.videoUrl,
    this.type,
    this.createdDate,
    this.textWithFile = false,
  });
  factory ChatVO.fromJson(Map<String, dynamic> json) => _$ChatVOFromJson(json);

  Map<String, dynamic> toJson() => _$ChatVOToJson(this);
}
