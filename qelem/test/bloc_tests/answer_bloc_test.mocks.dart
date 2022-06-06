// Mocks generated by Mockito 5.2.0 from annotations
// in qelem/test/bloc_tests/answer_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;

import 'package:mockito/mockito.dart' as _i1;
import 'package:qelem/domain/answer/answer.dart' as _i4;
import 'package:qelem/domain/answer/answer_form.dart' as _i5;
import 'package:qelem/domain/answer/answer_repository_interface.dart' as _i6;
import 'package:qelem/domain/auth/auth_repository_interface.dart' as _i10;
import 'package:qelem/domain/auth/change_password_form.dart' as _i14;
import 'package:qelem/domain/auth/login_form.dart' as _i13;
import 'package:qelem/domain/auth/login_response.dart' as _i12;
import 'package:qelem/domain/auth/registration_form.dart' as _i11;
import 'package:qelem/domain/auth/user.dart' as _i3;
import 'package:qelem/domain/auth/user_role.dart' as _i9;
import 'package:qelem/domain/common/vote.dart' as _i8;
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

class _FakeUser_1 extends _i1.Fake implements _i3.User {}

class _FakeDateTime_2 extends _i1.Fake implements DateTime {}

class _Fake$AnswerCopyWith_3<$Res> extends _i1.Fake
    implements _i4.$AnswerCopyWith<$Res> {}

class _Fake$AnswerFormCopyWith_4<$Res> extends _i1.Fake
    implements _i5.$AnswerFormCopyWith<$Res> {}

/// A class which mocks [AnswerRepositoryInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockAnswerRepositoryInterface extends _i1.Mock
    implements _i6.AnswerRepositoryInterface {
  MockAnswerRepositoryInterface() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i4.Answer>> getAnswerById(int? answerId) =>
      (super.noSuchMethod(Invocation.method(#getAnswerById, [answerId]),
              returnValue: Future<_i2.Either<_i4.Answer>>.value(
                  _FakeEither_0<_i4.Answer>()))
          as _i7.Future<_i2.Either<_i4.Answer>>);
  @override
  _i7.Future<_i2.Either<_i4.Answer>> createAnswer(
          {_i5.AnswerForm? answerForm}) =>
      (super.noSuchMethod(
              Invocation.method(#createAnswer, [], {#answerForm: answerForm}),
              returnValue: Future<_i2.Either<_i4.Answer>>.value(
                  _FakeEither_0<_i4.Answer>()))
          as _i7.Future<_i2.Either<_i4.Answer>>);
  @override
  _i7.Future<_i2.Either<void>> deleteAnswer(int? answerId) =>
      (super.noSuchMethod(Invocation.method(#deleteAnswer, [answerId]),
              returnValue:
                  Future<_i2.Either<void>>.value(_FakeEither_0<void>()))
          as _i7.Future<_i2.Either<void>>);
  @override
  _i7.Future<_i2.Either<_i4.Answer>> updateAnswer(_i4.Answer? answer) =>
      (super.noSuchMethod(Invocation.method(#updateAnswer, [answer]),
              returnValue: Future<_i2.Either<_i4.Answer>>.value(
                  _FakeEither_0<_i4.Answer>()))
          as _i7.Future<_i2.Either<_i4.Answer>>);
  @override
  _i7.Future<_i2.Either<_i4.Answer>> voteAnswer(
          int? answerId, _i8.Vote? vote) =>
      (super.noSuchMethod(Invocation.method(#voteAnswer, [answerId, vote]),
              returnValue: Future<_i2.Either<_i4.Answer>>.value(
                  _FakeEither_0<_i4.Answer>()))
          as _i7.Future<_i2.Either<_i4.Answer>>);
  @override
  _i7.Future<_i2.Either<List<_i4.Answer>>> getAnswersByQuestionId(
          int? questionId) =>
      (super.noSuchMethod(
              Invocation.method(#getAnswersByQuestionId, [questionId]),
              returnValue: Future<_i2.Either<List<_i4.Answer>>>.value(
                  _FakeEither_0<List<_i4.Answer>>()))
          as _i7.Future<_i2.Either<List<_i4.Answer>>>);
}

/// A class which mocks [User].
///
/// See the documentation for Mockito's code generation for more information.
class MockUser extends _i1.Mock implements _i3.User {
  MockUser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int get id =>
      (super.noSuchMethod(Invocation.getter(#id), returnValue: 0) as int);
  @override
  String get userName =>
      (super.noSuchMethod(Invocation.getter(#userName), returnValue: '')
          as String);
  @override
  String get firstName =>
      (super.noSuchMethod(Invocation.getter(#firstName), returnValue: '')
          as String);
  @override
  String get lastName =>
      (super.noSuchMethod(Invocation.getter(#lastName), returnValue: '')
          as String);
  @override
  String get profilePicture =>
      (super.noSuchMethod(Invocation.getter(#profilePicture), returnValue: '')
          as String);
  @override
  _i9.Role get role =>
      (super.noSuchMethod(Invocation.getter(#role), returnValue: _i9.Role.admin)
          as _i9.Role);
}

/// A class which mocks [Answer].
///
/// See the documentation for Mockito's code generation for more information.
class MockAnswer extends _i1.Mock implements _i4.Answer {
  MockAnswer() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int get id =>
      (super.noSuchMethod(Invocation.getter(#id), returnValue: 0) as int);
  @override
  String get content =>
      (super.noSuchMethod(Invocation.getter(#content), returnValue: '')
          as String);
  @override
  int get questionId =>
      (super.noSuchMethod(Invocation.getter(#questionId), returnValue: 0)
          as int);
  @override
  _i3.User get author => (super.noSuchMethod(Invocation.getter(#author),
      returnValue: _FakeUser_1()) as _i3.User);
  @override
  int get upVotes =>
      (super.noSuchMethod(Invocation.getter(#upVotes), returnValue: 0) as int);
  @override
  int get downVotes =>
      (super.noSuchMethod(Invocation.getter(#downVotes), returnValue: 0)
          as int);
  @override
  _i8.Vote get userVote => (super.noSuchMethod(Invocation.getter(#userVote),
      returnValue: _i8.Vote.upVote) as _i8.Vote);
  @override
  DateTime get createdAt => (super.noSuchMethod(Invocation.getter(#createdAt),
      returnValue: _FakeDateTime_2()) as DateTime);
  @override
  DateTime get updatedAt => (super.noSuchMethod(Invocation.getter(#updatedAt),
      returnValue: _FakeDateTime_2()) as DateTime);
  @override
  _i4.$AnswerCopyWith<_i4.Answer> get copyWith =>
      (super.noSuchMethod(Invocation.getter(#copyWith),
              returnValue: _Fake$AnswerCopyWith_3<_i4.Answer>())
          as _i4.$AnswerCopyWith<_i4.Answer>);
}

/// A class which mocks [AnswerForm].
///
/// See the documentation for Mockito's code generation for more information.
class MockAnswerForm extends _i1.Mock implements _i5.AnswerForm {
  MockAnswerForm() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int get questionId =>
      (super.noSuchMethod(Invocation.getter(#questionId), returnValue: 0)
          as int);
  @override
  String get content =>
      (super.noSuchMethod(Invocation.getter(#content), returnValue: '')
          as String);
  @override
  _i5.$AnswerFormCopyWith<_i5.AnswerForm> get copyWith =>
      (super.noSuchMethod(Invocation.getter(#copyWith),
              returnValue: _Fake$AnswerFormCopyWith_4<_i5.AnswerForm>())
          as _i5.$AnswerFormCopyWith<_i5.AnswerForm>);
}

/// A class which mocks [AuthRepositoryInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepositoryInterface extends _i1.Mock
    implements _i10.AuthRepositoryInterface {
  MockAuthRepositoryInterface() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i3.User>> register(
          {_i11.RegistrationForm? registerForm}) =>
      (super.noSuchMethod(
              Invocation.method(#register, [], {#registerForm: registerForm}),
              returnValue:
                  Future<_i2.Either<_i3.User>>.value(_FakeEither_0<_i3.User>()))
          as _i7.Future<_i2.Either<_i3.User>>);
  @override
  _i7.Future<_i2.Either<_i12.LoginReponse>> login(
          {_i13.LoginForm? loginForm}) =>
      (super.noSuchMethod(
              Invocation.method(#login, [], {#loginForm: loginForm}),
              returnValue: Future<_i2.Either<_i12.LoginReponse>>.value(
                  _FakeEither_0<_i12.LoginReponse>()))
          as _i7.Future<_i2.Either<_i12.LoginReponse>>);
  @override
  _i7.Future<_i2.Either<void>> changePassword(
          {_i14.ChangePasswordForm? changePasswordForm}) =>
      (super.noSuchMethod(
          Invocation.method(
              #changePassword, [], {#changePasswordForm: changePasswordForm}),
          returnValue:
              Future<_i2.Either<void>>.value(_FakeEither_0<void>())) as _i7
          .Future<_i2.Either<void>>);
  @override
  _i7.Future<String?> getAuthToken() =>
      (super.noSuchMethod(Invocation.method(#getAuthToken, []),
          returnValue: Future<String?>.value()) as _i7.Future<String?>);
  @override
  _i7.Future<void> logout() =>
      (super.noSuchMethod(Invocation.method(#logout, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<_i3.User?> getAuthenticatedUser() =>
      (super.noSuchMethod(Invocation.method(#getAuthenticatedUser, []),
          returnValue: Future<_i3.User?>.value()) as _i7.Future<_i3.User?>);
}