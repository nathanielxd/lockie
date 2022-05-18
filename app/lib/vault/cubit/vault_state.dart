part of 'vault_cubit.dart';

enum VaultStatus {idle, loading, error}

class VaultState extends Equatable {

  final Map<String, String> keys;
  final VaultStatus status;
  final String? errorMessage;

  const VaultState({
    required this.keys,
    required this.status,
    this.errorMessage,
  });

  factory VaultState.pure()
  => VaultState(
    keys: {},
    status: VaultStatus.loading
  );

  VaultState copyWith({
    Map<String, String>? keys,
    VaultStatus? status,
    String? errorMessage,
  }) => VaultState(
    keys: keys ?? this.keys,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  VaultState withIdle() => copyWith(status: VaultStatus.idle);
  VaultState withLoading() => copyWith(status: VaultStatus.loading);
  VaultState withError(String? errorMessage) => copyWith(status: VaultStatus.error, errorMessage: errorMessage);

  @override
  List<Object?> get props => [keys, status, errorMessage];
}
