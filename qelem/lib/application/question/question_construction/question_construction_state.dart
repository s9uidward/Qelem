import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qelem/domain/question/question.dart';
import 'package:qelem/domain/tag/tag.dart';
import '../../../util/error.dart';

part 'question_construction_state.freezed.dart';

@freezed
abstract class QuestionConstructionState with _$QuestionConstructionState {
  const factory QuestionConstructionState.empty() = QuestionPostStateEmpty;
  const factory QuestionConstructionState.error(Error error) =
      QuestionPostStateError;
  const factory QuestionConstructionState.loading() = QuestionPostStateLoading;
  const factory QuestionConstructionState.success(Question question) =
      QuestionPostStateSuccess;

  const factory QuestionConstructionState.loadingTags() =
      QuestionPostStateLoadingTags;
  const factory QuestionConstructionState.loadedTags(
          List<Tag> selectedTags, List<Tag> unslectedTags) =
      QuestionPostStateLoadedTags;
}
