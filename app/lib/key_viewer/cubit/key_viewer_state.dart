part of 'key_viewer_cubit.dart';

enum KeyViewerStatus {idle, loading, error, deleted}

class KeyViewerState extends Equatable {

  final String id;
  final String key;
  final bool obscured;
  final bool copied;
  final bool confirmedIdentity;
  final KeyViewerStatus status;
  final String? errorMessage;

  const KeyViewerState({
    required this.id,
    required this.key,
    required this.obscured,
    required this.copied,
    required this.confirmedIdentity,
    required this.status,
    this.errorMessage,
  });

  factory KeyViewerState.pure()
  => const KeyViewerState(
    id: '',
    key: '',
    obscured: true,
    copied: false,
    confirmedIdentity: false,
    status: KeyViewerStatus.idle
  );

  KeyViewerState copyWith({
    String? id,
    String? key,
    bool? obscured,
    bool? copied,
    bool? confirmedIdentity,
    KeyViewerStatus? status,
    String? errorMessage,
  }) => KeyViewerState(
    id: id ?? this.id,
    key: key ?? this.key,
    obscured: obscured ?? this.obscured,
    copied: copied ?? this.copied,
    confirmedIdentity: confirmedIdentity ?? this.confirmedIdentity,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  KeyViewerState withLoading() => copyWith(status: KeyViewerStatus.loading);
  KeyViewerState withDeleted() => copyWith(status: KeyViewerStatus.deleted);
  KeyViewerState withError(String? errorMessage) => copyWith(status: KeyViewerStatus.error, errorMessage: errorMessage);
  

  @override
  List<Object?> get props => [id, key, obscured, copied, confirmedIdentity, status, errorMessage];
}