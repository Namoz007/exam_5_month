import 'dart:convert';
import 'package:ExamFile/data/utils/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/user.dart';
import '../../../data/model/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/services/user/firebase_user_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseUserService firebaseUserService;
  final AuthRepository authRepository;

  AuthBloc({
    required this.authRepository,
    required this.firebaseUserService,
  }) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<AppStartedEvent>(_onAppStarted);
    on<LoginEvent>(_onLogin);
    on<CheckLoginEvent>(_onCheckLogin);
    on<LogoutEvent>(_onLogout);
    on<ResetPasswordEvent>(_onChangePassword);
    add(AppStartedEvent());
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.register(event.email, event.password);
      firebaseUserService.createUser(
        UserModel(
          email: event.email,
          name: event.name,
          imageUrl: '',
          uId: user.id,
          likes: [],
          saved: [],
        ),
      );

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(_handleError(e)));
    }
  }

  Future<void> _onAppStarted(
      AppStartedEvent event, Emitter<AuthState> emit) async {
    print('AppStartedEvent triggered');
    try {
      final isLoggedIn = await authRepository.isLoggedIn();
      print('Is logged in: $isLoggedIn');

      if (isLoggedIn) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        String? userData = sharedPreferences.getString('userData');
        print('User data from SharedPreferences: $userData');

        if (userData != null) {
          final user = User.fromMap(jsonDecode(userData));
          emit(AuthAuthenticated(user));
          print('Emitting AuthAuthenticated');
        } else {
          emit(AuthUnauthenticated());
          print('User data null, emitting AuthUnauthenticated');
        }
      } else {
        emit(AuthUnauthenticated());
        print('Not logged in, emitting AuthUnauthenticated');
      }
    } catch (e) {
      emit(AuthError('Failed to load app state'));
      print('Error: ${e.toString()}');
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(event.email, event.password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(
        AuthError(
          _handleError(e),
        ),
      );
    }
  }

  Future<void> _onCheckLogin(
      CheckLoginEvent event, Emitter<AuthState> emit) async {
    final isLoggedIn = await authRepository.isLoggedIn();
    if (isLoggedIn) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? userData = sharedPreferences.getString('userData');
      print(userData);
      final user = User.fromMap(jsonDecode(userData!));
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
  try {
    await authRepository.logout();
    emit(AuthUnauthenticated());
  } catch (error) {
    print('Logout error: $error');
  }
}


  Future<void> _onChangePassword(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.changePassword(event.email);
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(_handleError(e)));
    }
  }

  String _handleError(Object e) {
    String message = e.toString();
    if (message.contains("EMAIL_EXISTS")) {
      return "Bu email mavjud";
    } else if (message.contains("WEAK_PASSWORD")) {
      return "Parol juda qisqa!";
    } else if (message.contains("INVALID_LOGIN_CREDENTIALS")) {
      return "Parol yokiy email hato!";
    } else {
      return "Xato ro'y berdi. Iltimos, qayta urinib ko'ring.";
    }
  }
}
