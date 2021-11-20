import 'package:json_annotation/json_annotation.dart';
part 'liked_person_vo.g.dart';

@JsonSerializable()
class LikedPersonVO {
  @JsonKey(name: "liked_person_id")
  int? likedPersonId;

  @JsonKey(name: "liked_person_name")
  String? likedPersonName;

  LikedPersonVO({this.likedPersonId, this.likedPersonName});
  factory LikedPersonVO.fromJson(Map<String, dynamic> json) =>
      _$LikedPersonVOFromJson(json);

  Map<String, dynamic> toJson() => _$LikedPersonVOToJson(this);
}
