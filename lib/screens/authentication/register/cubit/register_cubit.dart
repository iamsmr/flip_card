import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flash_card/models/Failure.dart';
import 'package:flash_card/repositories/auth/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(RegisterState.initial());

  void fullNameChanged(String val) {
    emit(state.copyWith(fullname: val, status: RegisterStatus.initial));
  }

  void emailChanged(String val) {
    emit(state.copyWith(email: val, status: RegisterStatus.initial));
  }

  void passwordChanged(String val) {
    emit(state.copyWith(password: val, status: RegisterStatus.initial));
  }

  void createAccountWithCrid() async {
    if (!state.isValid && state.status == RegisterStatus.submitting) return;
    try {
      emit(state.copyWith(status: RegisterStatus.submitting));
      await _authRepository.createAccountWithEmailAndPassword(
        fullName: state.fullname,
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: RegisterStatus.success));
    } on Failure catch (e) {
      emit(state.copyWith(status: RegisterStatus.error, failure: e));
    }
  }
}
