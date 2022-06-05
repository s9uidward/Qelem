// Mocks generated by Mockito 5.2.0 from annotations
// in qelem/test/repo_tests/auth/auth_repo_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:qelem/domain/auth/auth_repository_interface.dart' as _i3;
import 'package:qelem/domain/auth/change_password_form.dart' as _i9;
import 'package:qelem/domain/auth/login_form.dart' as _i8;
import 'package:qelem/domain/auth/login_response.dart' as _i7;
import 'package:qelem/domain/auth/registration_form.dart' as _i6;
import 'package:qelem/domain/auth/user.dart' as _i5;
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

/// A class which mocks [AuthRepositoryInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepositoryInterface extends _i1.Mock
    implements _i3.AuthRepositoryInterface {
  MockAuthRepositoryInterface() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.User>> register(
          {_i6.RegistrationForm? registerForm}) =>
      (super.noSuchMethod(
              Invocation.method(#register, [], {#registerForm: registerForm}),
              returnValue:
                  Future<_i2.Either<_i5.User>>.value(_FakeEither_0<_i5.User>()))
          as _i4.Future<_i2.Either<_i5.User>>);
  @override
  _i4.Future<_i2.Either<_i7.LoginReponse>> login({_i8.LoginForm? loginForm}) =>
      (super.noSuchMethod(
              Invocation.method(#login, [], {#loginForm: loginForm}),
              returnValue: Future<_i2.Either<_i7.LoginReponse>>.value(
                  _FakeEither_0<_i7.LoginReponse>()))
          as _i4.Future<_i2.Either<_i7.LoginReponse>>);
  @override
  _i4.Future<_i2.Either<void>> changePassword(
          {_i9.ChangePasswordForm? changePasswordForm}) =>
      (super.noSuchMethod(
          Invocation.method(
              #changePassword, [], {#changePasswordForm: changePasswordForm}),
          returnValue:
              Future<_i2.Either<void>>.value(_FakeEither_0<void>())) as _i4
          .Future<_i2.Either<void>>);
  @override
  _i4.Future<String?> getAuthToken() =>
      (super.noSuchMethod(Invocation.method(#getAuthToken, []),
          returnValue: Future<String?>.value()) as _i4.Future<String?>);
  @override
  _i4.Future<void> logout() =>
      (super.noSuchMethod(Invocation.method(#logout, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<_i5.User?> getAuthenticatedUser() =>
      (super.noSuchMethod(Invocation.method(#getAuthenticatedUser, []),
          returnValue: Future<_i5.User?>.value()) as _i4.Future<_i5.User?>);
}
