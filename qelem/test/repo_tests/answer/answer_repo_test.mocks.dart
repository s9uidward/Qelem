// Mocks generated by Mockito 5.2.0 from annotations
// in qelem/test/repo_tests/answer/answer_repo_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:qelem/domain/answer/answer.dart' as _i5;
import 'package:qelem/domain/answer/answer_form.dart' as _i6;
import 'package:qelem/domain/answer/answer_repository_interface.dart' as _i3;
import 'package:qelem/domain/common/vote.dart' as _i7;
import 'package:qelem/util/either.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<T> extends _i1.Fake implements _i2.Either<T> {}

/// A class which mocks [AnswerRepositoryInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockAnswerRepositoryInterface extends _i1.Mock
    implements _i3.AnswerRepositoryInterface {
  MockAnswerRepositoryInterface() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<List<_i5.Answer>>> getAllAnswers() =>
      (super.noSuchMethod(Invocation.method(#getAllAnswers, []),
              returnValue: Future<_i2.Either<List<_i5.Answer>>>.value(
                  _FakeEither_0<List<_i5.Answer>>()))
          as _i4.Future<_i2.Either<List<_i5.Answer>>>);
  @override
  _i4.Future<_i2.Either<_i5.Answer>> getAnswerById(int? answerId) =>
      (super.noSuchMethod(Invocation.method(#getAnswerById, [answerId]),
              returnValue: Future<_i2.Either<_i5.Answer>>.value(
                  _FakeEither_0<_i5.Answer>()))
          as _i4.Future<_i2.Either<_i5.Answer>>);
  @override
  _i4.Future<_i2.Either<_i5.Answer>> createAnswer(
          {_i6.AnswerForm? answerForm}) =>
      (super.noSuchMethod(
              Invocation.method(#createAnswer, [], {#answerForm: answerForm}),
              returnValue: Future<_i2.Either<_i5.Answer>>.value(
                  _FakeEither_0<_i5.Answer>()))
          as _i4.Future<_i2.Either<_i5.Answer>>);
  @override
  _i4.Future<_i2.Either<void>> deleteAnswer(int? answerId) =>
      (super.noSuchMethod(Invocation.method(#deleteAnswer, [answerId]),
              returnValue:
                  Future<_i2.Either<void>>.value(_FakeEither_0<void>()))
          as _i4.Future<_i2.Either<void>>);
  @override
  _i4.Future<_i2.Either<_i5.Answer>> updateAnswer(_i5.Answer? answer) =>
      (super.noSuchMethod(Invocation.method(#updateAnswer, [answer]),
              returnValue: Future<_i2.Either<_i5.Answer>>.value(
                  _FakeEither_0<_i5.Answer>()))
          as _i4.Future<_i2.Either<_i5.Answer>>);
  @override
  _i4.Future<_i2.Either<_i5.Answer>> voteAnswer(
          int? answerId, _i7.Vote? vote) =>
      (super.noSuchMethod(Invocation.method(#voteAnswer, [answerId, vote]),
              returnValue: Future<_i2.Either<_i5.Answer>>.value(
                  _FakeEither_0<_i5.Answer>()))
          as _i4.Future<_i2.Either<_i5.Answer>>);
  @override
  _i4.Future<_i2.Either<List<_i5.Answer>>> getAnswersByQuestionId(
          int? questionId) =>
      (super.noSuchMethod(
              Invocation.method(#getAnswersByQuestionId, [questionId]),
              returnValue: Future<_i2.Either<List<_i5.Answer>>>.value(
                  _FakeEither_0<List<_i5.Answer>>()))
          as _i4.Future<_i2.Either<List<_i5.Answer>>>);
}
