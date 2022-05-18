part of 'authentication_email_cubit.dart';

class AuthenticationEmailState extends Equatable {

  final EmailInput email;
  final FormzStatus status;
  final String? errorMessage;

  const AuthenticationEmailState({
    required this.email,
    required this.status,
    this.errorMessage,
  });

  factory AuthenticationEmailState.pure()
  => const AuthenticationEmailState(
    email: EmailInput.pure(),
    status: FormzStatus.pure,
  );

  AuthenticationEmailState copyWith({
    EmailInput? email,
    FormzStatus? status,
    String? errorMessage,
  }) => AuthenticationEmailState(
    email: email ?? this.email,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  AuthenticationEmailState withLoading() => copyWith(status: FormzStatus.submissionInProgress);
  AuthenticationEmailState withSuccess() => copyWith(status: FormzStatus.submissionSuccess);
  AuthenticationEmailState withError(String? errorMessage) => copyWith(status: FormzStatus.submissionFailure, errorMessage: errorMessage);

  @override
  List<Object?> get props => [email, status, errorMessage];
}