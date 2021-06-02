part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, error, success }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final Failure failure;


  /// `return` true when email and password field are not empty   
  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  /// initial State
  factory LoginState.initial() {
    return LoginState(
      email: "",
      password: "",
      status: LoginStatus.initial,
      failure: Failure(),
    );
  }

  LoginState({
    required this.email,
    required this.password,
    required this.status,
    required this.failure,
  });

  @override
  List<Object> get props => [email, password, status, failure];

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    Failure? failure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
