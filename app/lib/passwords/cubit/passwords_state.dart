part of 'passwords_cubit.dart';

enum PasswordsStatus {idle, loading, error, copied}

class PasswordsState extends Equatable {

  final List<Password> passwords;
  final String search;
  final Password? selected;
  final PasswordsStatus status;
  final String? errorMessage;

  const PasswordsState({
    required this.passwords,
    required this.search,
    this.selected,
    required this.status,
    this.errorMessage,
  });

  factory PasswordsState.pure()
  => const PasswordsState(
    passwords: [],
    search: '',
    status: PasswordsStatus.idle,
  );

  PasswordsState copyWith({
    List<Password>? passwords,
    String? search,
    Password? selected,
    PasswordsStatus? status,
    String? errorMessage,
  }) => PasswordsState(
    passwords: passwords ?? this.passwords,
    search: search ?? this.search,
    selected: selected ?? this.selected,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  PasswordsState withLoading() => copyWith(status: PasswordsStatus.loading);
  PasswordsState withCopied() => copyWith(status: PasswordsStatus.copied);
  PasswordsState withIdle() => copyWith(status: PasswordsStatus.idle);
  PasswordsState withError(String? errorMessage) => copyWith(status: PasswordsStatus.error, errorMessage: errorMessage);
  

  @override
  List<Object?> get props => [passwords, search, selected, status, errorMessage];
}