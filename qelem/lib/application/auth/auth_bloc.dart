import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qelem/data/local/shared_prefs/shared_prefs_service.dart';
import 'package:qelem/infrastructure/auth/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final SharedPrefsService sharedPrefsService;

  AuthBloc({required this.authRepository, required this.sharedPrefsService}) : super(const AuthUnInitialized()) {
    () async {
      var authToken = await authRepository.getAuthToken();
      bool firstRun = await sharedPrefsService.isFirstRun();
      emit(AppInitialized(token: authToken, isFirstRun: firstRun));
    }();

    on<AuthEventSignedIn>(
      ((event, emit) async {
        sharedPrefsService.setFirstRun(false);
        emit(AuthAuthenticated(event.user, event.token));
      }),
    );
    on<AuthEventSignOut>(((event, emit) async {
      await authRepository.logout();
      emit(const AuthUnauthenticated());
    }));
  }
}
