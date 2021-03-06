import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qelem/application/login/login_event.dart';
import 'package:qelem/application/login/login_state.dart';
import 'package:qelem/domain/auth/auth_repository_interface.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepositoryInterface _authRepository;

  LoginBloc(this._authRepository) : super(const LoginState.initial()) {
    on<LoginEventLogin>(
      ((event, emit) async {
        emit(const LoginStateLoading());
        var result = await _authRepository.login(loginForm: event.form);

        if (result.hasError) {
          emit(LoginStateFailure(result.error!));
        } else {
          emit(LoginStateSuccess(result.val!.user, result.val!.jwt));
        }
      }),
    );
  }
}
