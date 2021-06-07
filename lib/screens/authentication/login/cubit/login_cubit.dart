import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flash_card/models/models.dart';
import 'package:flash_card/repositories/repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginState.initial());

  /// call when [email] changed
  void emailChanged(String val) {
    emit(state.copyWith(email: val, status: LoginStatus.initial));
  }

  /// call wehen [password] changed
  void passwordChange(String val) {
    emit(state.copyWith(password: val, status: LoginStatus.initial));
  }

  /// called when login button is [submited]
  void loginWithCred() async {
    if (!state.isValid && state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.loginWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: LoginStatus.success));
    } on Failure catch (e) {
      emit(state.copyWith(failure: e, status: LoginStatus.error));
    }
  }

  void loginWithGoogleAcc() async {
    if (!state.isValid && state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.loginWithGoogleAccount();
    } on Failure catch (e) {
      emit(state.copyWith(failure: e, status: LoginStatus.error));
    }
  }
}
