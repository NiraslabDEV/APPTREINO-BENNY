import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';

// --- Events ---
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class LoginWithEmailRequested extends AuthEvent {
  final String email;
  final String password;
  const LoginWithEmailRequested({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String role;
  const RegisterRequested({
    required this.email,
    required this.password,
    required this.name,
    this.role = 'aluno',
  });
  @override
  List<Object> get props => [email, password, name, role];
}

class LoginWithGoogleRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

// --- States ---
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity user;
  const AuthAuthenticated(this.user);
  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object> get props => [message];
}

class AuthUnauthenticated extends AuthState {}

// --- BLoC ---
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  final GoogleSignIn _googleSignIn;

  AuthBloc({
    required AuthRepository repository,
    GoogleSignIn? googleSignIn,
  })  : _repository = repository,
        _googleSignIn = googleSignIn ??
            GoogleSignIn(
              clientId: AppConstants.googleClientId,
              scopes: ['email', 'profile'],
            ),
        super(AuthInitial()) {
    on<LoginWithEmailRequested>(_onEmailLogin);
    on<RegisterRequested>(_onRegister);
    on<LoginWithGoogleRequested>(_onGoogleLogin);
    on<LogoutRequested>(_onLogout);
  }

  Future<void> _onRegister(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _repository.register(
        event.email, event.password, event.name, event.role);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onEmailLogin(
    LoginWithEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result =
        await _repository.loginWithEmail(event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onGoogleLogin(
    LoginWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(AuthInitial()); // usuário cancelou
        return;
      }
      final auth = await googleUser.authentication;
      final idToken = auth.idToken;
      if (idToken == null) {
        emit(const AuthError('Falha na autenticação com Google.'));
        return;
      }
      final result = await _repository.loginWithGoogle(idToken);
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthAuthenticated(user)),
      );
    } catch (_) {
      emit(const AuthError('Falha na autenticação com Google.'));
    }
  }

  Future<void> _onLogout(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _googleSignIn.signOut();
    await _repository.logout();
    emit(AuthUnauthenticated());
  }
}
