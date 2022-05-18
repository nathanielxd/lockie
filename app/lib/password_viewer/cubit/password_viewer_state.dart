part of 'password_viewer_cubit.dart';

enum PasswordViewerStatus {idle, loading, error, deleted}

class PasswordViewerState extends Equatable {

  final Password password;
  final String decrypted;
  final bool obscured;
  final bool confirmedIdentity;
  final PasswordViewerStatus status;
  final String? errorMessage;

  const PasswordViewerState({
    required this.password,
    required this.decrypted,
    required this.obscured,
    required this.confirmedIdentity,
    required this.status,
    this.errorMessage,
  });

  factory PasswordViewerState.pure()
  => PasswordViewerState(
    password: Password.empty, 
    decrypted: '', 
    obscured: true, 
    confirmedIdentity: false,
    status: PasswordViewerStatus.idle
  );

  PasswordViewerState copyWith({
    Password? password,
    String? decrypted,
    bool? obscured,
    bool? copied,
    bool? confirmedIdentity,
    PasswordViewerStatus? status,
    String? errorMessage,
  }) => PasswordViewerState(
    password: password ?? this.password,
    decrypted: decrypted ?? this.decrypted,
    obscured: obscured ?? this.obscured,
    confirmedIdentity: confirmedIdentity ?? this.confirmedIdentity,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  PasswordViewerState withLoading() => copyWith(status: PasswordViewerStatus.loading);
  PasswordViewerState withIdle() => copyWith(status: PasswordViewerStatus.idle);
  PasswordViewerState withError(String? errorMessage) => copyWith(status: PasswordViewerStatus.error, errorMessage: errorMessage);
  PasswordViewerState withDeleted() => copyWith(status: PasswordViewerStatus.deleted);

  @override
  List<Object?> get props => [password, decrypted, obscured, confirmedIdentity, status, errorMessage];
}
