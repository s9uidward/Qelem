// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_form_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QuestionFormDto _$$_QuestionFormDtoFromJson(Map<String, dynamic> json) =>
    _$_QuestionFormDto(
      topic: json['topic'] as String,
      content: json['content'] as String,
      tagIds: (json['tagIds'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$_QuestionFormDtoToJson(_$_QuestionFormDto instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'content': instance.content,
      'tagIds': instance.tagIds,
    };
