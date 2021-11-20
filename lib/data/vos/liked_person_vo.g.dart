// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liked_person_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikedPersonVO _$LikedPersonVOFromJson(Map<String, dynamic> json) =>
    LikedPersonVO(
      likedPersonId: json['liked_person_id'] as int?,
      likedPersonName: json['liked_person_name'] as String?,
    );

Map<String, dynamic> _$LikedPersonVOToJson(LikedPersonVO instance) =>
    <String, dynamic>{
      'liked_person_id': instance.likedPersonId,
      'liked_person_name': instance.likedPersonName,
    };
