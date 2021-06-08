part of 'create_card_cubit.dart';

enum CreateCardStatus { initial, submitting, success, error }

class CreateCardState extends Equatable {
  final Decks selectedDecks;
  final String frontText;
  final String backText;
  final Color selectedColor;
  final Failure failure;
  final CreateCardStatus status;

  const CreateCardState({
    required this.selectedDecks,
    required this.frontText,
    required this.backText,
    required this.selectedColor,
    required this.failure,
    required this.status,
  });

  factory CreateCardState.initila() {
    return CreateCardState(
      selectedDecks: Decks.empty,
      frontText: "",
      backText: "",
      selectedColor: Color(0xffFFE58A),
      failure: Failure(),
      status: CreateCardStatus.initial,
    );
  }

  @override
  List<Object> get props => [selectedColor, frontText, backText, selectedColor];

  CreateCardState copyWith({
    Decks? selectedDecks,
    String? frontText,
    String? backText,
    Color? selectedColor,
    Failure? failure,
    CreateCardStatus? status,
  }) {
    return CreateCardState(
      selectedDecks: selectedDecks ?? this.selectedDecks,
      frontText: frontText ?? this.frontText,
      backText: backText ?? this.backText,
      selectedColor: selectedColor ?? this.selectedColor,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
