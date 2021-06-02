part of 'auth_bloc.dart';

enum AuthStatus { unknown, unauthenticated, authenticated, error }

class AuthState extends Equatable {
  final auth.User? user;
  final AuthStatus status;

  const AuthState({
    this.user,
    required this.status,
  });

  factory AuthState.initial() {
    return const AuthState(status: AuthStatus.unknown, user: null);
  }

  factory AuthState.unauthenticated() {
    return AuthState(status: AuthStatus.unauthenticated);
  }

  factory AuthState.authenticated({required auth.User user}) {
    return AuthState(status: AuthStatus.authenticated, user: user);
  }

  @override
  List<Object?> get props => [user, status];
}
