import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/login_user.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUser loginUser;

  AuthCubit({required this.loginUser}) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    final user = User(email: email, password: password);
    final result = await loginUser(user);

    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (success) =>
          success
              ? emit(AuthAuthenticated())
              : emit(const AuthError('Login failed')),
    );
  }

  Future<void> checkLoginStatus() async {
    emit(AuthLoading());

    final result = await loginUser.repository.isUserLoggedIn();

    result.fold(
      (failure) => emit(AuthUnauthenticated()),
      (isLoggedIn) =>
          isLoggedIn ? emit(AuthAuthenticated()) : emit(AuthUnauthenticated()),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());

    final result = await loginUser.repository.logoutUser();

    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (_) => emit(AuthUnauthenticated()),
    );
  }
}
