// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentVO _$MomentVOFromJson(Map<String, dynamic> json) => MomentVO(
      id: json['id'] as int?,
      description: json['description'] as String?,
      profilePicture: json['profile_picture'] as String?,
      userName: json['user_name'] as String?,
      postImage: json['post_image'] as String?,
      comment: (json['comment'] as List<dynamic>?)
          ?.map((e) => CommentVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      likedPerson: (json['liked_person'] as List<dynamic>?)
          ?.map((e) => LikedPersonVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdDate: json['created_date'] as String?,
      showLikedPerson: json['showLikedPerson'] as bool? ?? false,
      showComment: json['showComment'] as bool? ?? false,
      isLiked: json['is_liked'] as bool?,
      fileType: json['file_type'] as String?,
    );

Map<String, dynamic> _$MomentVOToJson(MomentVO instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'profile_picture': instance.profilePicture,
      'user_name': instance.userName,
      'post_image': instance.postImage,
      'comment': instance.comment,
      'liked_person': instance.likedPerson,
      'created_date': instance.createdDate,
      'showLikedPerson': instance.showLikedPerson,
      'showComment': instance.showComment,
      'is_liked': instance.isLiked,
      'file_type': instance.fileType,
    };
