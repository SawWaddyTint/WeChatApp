// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentVO _$CommentVOFromJson(Map<String, dynamic> json) => CommentVO(
      commentId: json['comment_id'] as int?,
      commentDesciption: json['comment_description'] as String?,
      commentedPersonName: json['commented_person_name'] as String?,
    );

Map<String, dynamic> _$CommentVOToJson(CommentVO instance) => <String, dynamic>{
      'comment_id': instance.commentId,
      'comment_description': instance.commentDesciption,
      'commented_person_name': instance.commentedPersonName,
    };
