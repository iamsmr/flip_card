part of 'register_cubit.dart';

enum RegisterStatus { initial, submitting, error, success }

class RegisterState extends Equatable {
  final String fullname;
  final String email;
  final String password;
  final Failure failure;
  final RegisterStatus status;

  const RegisterState({
    required this.fullname,
    required this.email,
    required this.password,
    required this.failure,
    required this.status,
  });

  /// `return` true when email and password field are not empty
  bool get isValid => email.isNotEmpty && password.isNotEmpty && fullname.isNotEmpty;

  /// initial State
  factory RegisterState.initial() {
    return RegisterState(
      email: "",
      password: "",
      fullname: "",
      failure: Failure(),
      status: RegisterStatus.initial,
    );
  }

  @override
  List<Object> get props => [fullname, email, password, failure, status];

  RegisterState copyWith({
    String? fullname,
    String? email,
    String? password,
    Failure? failure,
    RegisterStatus? status,
  }) {
    return RegisterState(
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      password: password ?? this.password,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
