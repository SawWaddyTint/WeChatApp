import 'package:json_annotation/json_annotation.dart';

part 'chat_vo.g.dart';

@JsonSerializable()
class ChatVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "created_date")
  String? createdDate;

  ChatVO(
    this.id,
    this.message,
    this.type,
    this.createdDate,
  );
  factory ChatVO.fromJson(Map<String, dynamic> json) => _$ChatVOFromJson(json);

  Map<String, dynamic> toJson() => _$ChatVOToJson(this);
}
