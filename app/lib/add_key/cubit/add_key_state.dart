part of 'add_key_cubit.dart';

class AddKeyState extends Equatable {

  final IdInput id;
  final KeyInput key;
  final FormzStatus status;
  final String? errorMessage;

  const AddKeyState({
    required this.id,
    required this.key,
    required this.status,
    this.errorMessage,
  });

  factory AddKeyState.pure()
  => const AddKeyState(
    id: IdInput.pure(),
    key: KeyInput.pure(),
    status: FormzStatus.pure,
  );

  AddKeyState copyWith({
    IdInput? id,
    KeyInput? key,
    FormzStatus? status,
    String? errorMessage,
  }) => AddKeyState(
    id: id ?? this.id,
    key: key ?? this.key,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  AddKeyState withLoading() => copyWith(status: FormzStatus.submissionInProgress);
  AddKeyState withSuccess() => copyWith(status: FormzStatus.submissionSuccess);
  AddKeyState withError(String? errorMessage) => copyWith(status: FormzStatus.submissionFailure, errorMessage: errorMessage);

  @override
  List<Object?> get props => [id, key, status, errorMessage];
}