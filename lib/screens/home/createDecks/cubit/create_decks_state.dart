part of 'create_decks_cubit.dart';

enum CreateDecksStatus { initial, submitting, success, error }

class CreateDecksState extends Equatable {
  final Color selectedColor;
  final String decksTitle;
  final CreateDecksStatus status;
  final Failure failure;

  CreateDecksState({
    required this.failure,
    required this.selectedColor,
    required this.decksTitle,
    required this.status,
  });

  factory CreateDecksState.initial() {
    return CreateDecksState(
      failure: Failure(),
      selectedColor: Color(0xffFFA68A),
      decksTitle: "",
      status: CreateDecksStatus.initial,
    );
  }

  @override
  List<Object> get props => [selectedColor, status, decksTitle, failure];

  CreateDecksState copyWith({
    Color? selectedColor,
    String? decksTitle,
    CreateDecksStatus? status,
    Failure? failure,
  }) {
    return CreateDecksState(
      selectedColor: selectedColor ?? this.selectedColor,
      decksTitle: decksTitle ?? this.decksTitle,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
