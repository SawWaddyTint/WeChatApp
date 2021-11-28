// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatVO _$ChatVOFromJson(Map<String, dynamic> json) => ChatVO(
      id: json['id'] as int?,
      text: json['text'] as String?,
      imageUrl: json['image_url'] as String?,
      videoUrl: json['video_url'] as String?,
      type: json['type'] as String?,
      createdDate: json['created_date'] as String?,
      textWithFile: json['textWithFile'] as bool? ?? false,
    );

Map<String, dynamic> _$ChatVOToJson(ChatVO instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'image_url': instance.imageUrl,
      'video_url': instance.videoUrl,
      'type': instance.type,
      'created_date': instance.createdDate,
      'textWithFile': instance.textWithFile,
    };
