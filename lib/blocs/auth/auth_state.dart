part of 'auth_bloc.dart';

enum AuthStatus { unknown, unauthenticated, authenticated, error }

class AuthState extends Equatable {
  final auth.User? user;
  final AuthStatus status;

  const AuthState({
    this.user,
    this.status = AuthStatus.unknown,
  });

  factory AuthState.initial() => const AuthState();

  factory AuthState.unauthenticated() {
    return AuthState(status: AuthStatus.unauthenticated);
  }

  factory AuthState.authenticated({required auth.User user}) {
    return AuthState(status: AuthStatus.authenticated, user: user);
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [user, status];
}
