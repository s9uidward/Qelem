// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QuestionDto _$$_QuestionDtoFromJson(Map<String, dynamic> json) =>
    _$_QuestionDto(
      id: json['id'] as int,
      topic: json['topic'] as String,
      content: json['content'] as String,
      author: UserDto.fromJson(json['author'] as Map<String, dynamic>),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as String),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as String),
      upVotes: json['upVotes'] as int,
      downVotes: json['downVotes'] as int,
      userVote: json['userVote'] as int,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => TagDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_QuestionDtoToJson(_$_QuestionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'content': instance.content,
      'author': instance.author,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'upVotes': instance.upVotes,
      'downVotes': instance.downVotes,
      'userVote': instance.userVote,
      'tags': instance.tags,
    };
