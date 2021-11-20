import 'package:json_annotation/json_annotation.dart';
import 'package:we_chat_app/data/vos/comment_vo.dart';
import 'package:we_chat_app/data/vos/liked_person_vo.dart';

part 'moment_vo.g.dart';

@JsonSerializable()
class MomentVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "profile_picture")
  String? profilePicture;

  @JsonKey(name: "user_name")
  String? userName;

  @JsonKey(name: "post_image")
  String? postImage;

  @JsonKey(name: "comment")
  List<CommentVO>? comment;

  @JsonKey(name: "liked_person")
  List<LikedPersonVO>? likedPerson;

  @JsonKey(name: "created_date")
  String? createdDate;

  bool? showLikedPerson;
  bool? showComment;

  @JsonKey(name: "is_liked")
  bool? isLiked;

  @JsonKey(name: "file_type")
  String? fileType;

  MomentVO({
    this.id,
    this.description,
    this.profilePicture,
    this.userName,
    this.postImage,
    this.comment,
    this.likedPerson,
    this.createdDate,
    this.showLikedPerson = false,
    this.showComment = false,
    this.isLiked,
    this.fileType,
  });

  factory MomentVO.fromJson(Map<String, dynamic> json) =>
      _$MomentVOFromJson(json);

  Map<String, dynamic> toJson() => _$MomentVOToJson(this);
}
