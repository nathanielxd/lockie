import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lockie_account/lockie_account.dart';
import 'package:lockie_app/authentication_email/authentication_email.dart';

part 'authentication_email_state.dart';

class AuthenticationEmailCubit extends Cubit<AuthenticationEmailState> {

  final IAuthenticationRepository authenticationRepository;

  AuthenticationEmailCubit({
    required this.authenticationRepository
  }) : super(AuthenticationEmailState.pure());

  void emailChanged(String value) {
    final email = EmailInput.dirty(value);
    emit(state.copyWith(email: email, status: Formz.validate([email])));
  }

  void submit() async {
    if(state.status.isInvalid) return;
    try {
      emit(state.withLoading());
      await authenticationRepository.sendMagicLink(state.email.value);
      emit(state.withSuccess());
    }
    on AuthenticationException catch(e) {
      emit(state.withError(e.message));
    }
    on Exception {
      emit(state.withError('An unknown error has occurred.'));
    }
  }
}