part of 'magic_link_confirmation_cubit.dart';

class MagicLinkConfirmationState extends Equatable {

  final DateTime? lastRequested;
  final FormzStatus status;
  final String? errorMessage;

  const MagicLinkConfirmationState({
    this.lastRequested,
    required this.status,
    this.errorMessage,
  });

  factory MagicLinkConfirmationState.pure()
  => const MagicLinkConfirmationState(
    status: FormzStatus.pure,
  );

  MagicLinkConfirmationState copyWith({
    DateTime? lastRequested,
    FormzStatus? status,
    String? errorMessage,
  }) => MagicLinkConfirmationState(
    lastRequested: lastRequested ?? this.lastRequested,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [lastRequested, status, errorMessage];
}