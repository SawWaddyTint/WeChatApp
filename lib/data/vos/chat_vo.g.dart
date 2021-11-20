// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatVO _$ChatVOFromJson(Map<String, dynamic> json) => ChatVO(
      json['id'] as int?,
      json['message'] as String?,
      json['type'] as String?,
      json['created_date'] as String?,
    );

Map<String, dynamic> _$ChatVOToJson(ChatVO instance) => <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'type': instance.type,
      'created_date': instance.createdDate,
    };
