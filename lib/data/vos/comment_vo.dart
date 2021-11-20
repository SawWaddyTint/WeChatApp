import 'package:json_annotation/json_annotation.dart';
part 'comment_vo.g.dart';

@JsonSerializable()
class CommentVO {
  @JsonKey(name: "comment_id")
  int? commentId;

  @JsonKey(name: "comment_description")
  String? commentDesciption;

  @JsonKey(name: "commented_person_name")
  String? commentedPersonName;

  CommentVO({
    this.commentId,
    this.commentDesciption,
    this.commentedPersonName,
  });
  factory CommentVO.fromJson(Map<String, dynamic> json) =>
      _$CommentVOFromJson(json);

  Map<String, dynamic> toJson() => _$CommentVOToJson(this);
}
