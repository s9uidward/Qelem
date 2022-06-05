// Mocks generated by Mockito 5.2.0 from annotations
// in qelem/test/question_detail_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:qelem/domain/common/vote.dart' as _i9;
import 'package:qelem/domain/question/question.dart' as _i7;
import 'package:qelem/domain/question/question_form.dart' as _i8;
import 'package:qelem/infrastructure/auth/auth_repository.dart' as _i3;
import 'package:qelem/infrastructure/question/question_api.dart' as _i2;
import 'package:qelem/infrastructure/question/question_repository.dart' as _i5;
import 'package:qelem/util/either.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeQuestionApi_0 extends _i1.Fake implements _i2.QuestionApi {}

class _FakeAuthRepository_1 extends _i1.Fake implements _i3.AuthRepository {}

class _FakeEither_2<T> extends _i1.Fake implements _i4.Either<T> {}

/// A class which mocks [QuestionRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockQuestionRepository extends _i1.Mock
    implements _i5.QuestionRepository {
  MockQuestionRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.QuestionApi get questionApi =>
      (super.noSuchMethod(Invocation.getter(#questionApi),
          returnValue: _FakeQuestionApi_0()) as _i2.QuestionApi);
  @override
  _i3.AuthRepository get authRepository =>
      (super.noSuchMethod(Invocation.getter(#authRepository),
          returnValue: _FakeAuthRepository_1()) as _i3.AuthRepository);
  @override
  _i6.Future<_i4.Either<List<_i7.Question>>> getMyQuestions() =>
      (super.noSuchMethod(Invocation.method(#getMyQuestions, []),
              returnValue: Future<_i4.Either<List<_i7.Question>>>.value(
                  _FakeEither_2<List<_i7.Question>>()))
          as _i6.Future<_i4.Either<List<_i7.Question>>>);
  @override
  _i6.Future<_i4.Either<List<_i7.Question>>> getAllQuestions() =>
      (super.noSuchMethod(Invocation.method(#getAllQuestions, []),
              returnValue: Future<_i4.Either<List<_i7.Question>>>.value(
                  _FakeEither_2<List<_i7.Question>>()))
          as _i6.Future<_i4.Either<List<_i7.Question>>>);
  @override
  _i6.Future<_i4.Either<_i7.Question>> getQuestionById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getQuestionById, [id]),
              returnValue: Future<_i4.Either<_i7.Question>>.value(
                  _FakeEither_2<_i7.Question>()))
          as _i6.Future<_i4.Either<_i7.Question>>);
  @override
  _i6.Future<_i4.Either<_i7.Question>> createQuestion(
          _i8.QuestionForm? questionForm) =>
      (super.noSuchMethod(Invocation.method(#createQuestion, [questionForm]),
              returnValue: Future<_i4.Either<_i7.Question>>.value(
                  _FakeEither_2<_i7.Question>()))
          as _i6.Future<_i4.Either<_i7.Question>>);
  @override
  _i6.Future<_i4.Either<void>> deleteQuestion(int? id) => (super.noSuchMethod(
          Invocation.method(#deleteQuestion, [id]),
          returnValue: Future<_i4.Either<void>>.value(_FakeEither_2<void>()))
      as _i6.Future<_i4.Either<void>>);
  @override
  _i6.Future<_i4.Either<_i7.Question>> updateQuestion(
          _i8.QuestionForm? questionForm, int? questionId) =>
      (super.noSuchMethod(
              Invocation.method(#updateQuestion, [questionForm, questionId]),
              returnValue: Future<_i4.Either<_i7.Question>>.value(
                  _FakeEither_2<_i7.Question>()))
          as _i6.Future<_i4.Either<_i7.Question>>);
  @override
  _i6.Future<_i4.Either<_i7.Question>> voteQuestion(
          int? questionId, _i9.Vote? vote) =>
      (super.noSuchMethod(Invocation.method(#voteQuestion, [questionId, vote]),
              returnValue: Future<_i4.Either<_i7.Question>>.value(
                  _FakeEither_2<_i7.Question>()))
          as _i6.Future<_i4.Either<_i7.Question>>);
}
