import 'dart:async';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lockie_locker/lockie_locker.dart';
import 'package:lockie_vault/lockie_vault.dart';

part 'passwords_state.dart';

class PasswordsCubit extends Cubit<PasswordsState> {

  final IPasswordsRepository passwordsRepository;
  final IVaultRepository vaultRepository;

  PasswordsCubit({
    required this.passwordsRepository,
    required this.vaultRepository
  }) : super(PasswordsState.pure()) {
    emit(state.copyWith(passwords: passwordsRepository.currentPasswords));
    passwordsRepository.stream.listen((passwords) {
      if(!isClosed) {
        emit(state.copyWith(passwords: passwords));
      }
    });
  }

  /// Decrypt a password and return it's value.
  Future<String> decrypt(Password password) async {
    try {
      // Use the password's stored key id to get the key value from secure local storage.
      final utf8Key = await vaultRepository.get(password.key);
      final key = Key.fromUtf8(utf8Key);

      /// Decrypt the password with the key and return it.
      final decrypted = Encrypter(AES(key))
        .decrypt64(password.sequence, 
          iv: IV.fromBase64(password.iv)
        );

      return decrypted;
    }
    on VaultException catch(e) {
      emit(state.withError(e.message));
      return '';
    }
    on Exception {
      emit(state.withError('An unknown error has occurred. Please try again later.'));
      return '';
    }
  }

  /// Set that a password was copied into clipboard or not.
  void copied() => emit(state.copyWith(status: PasswordsStatus.copied));

  /// Select a password and highlight it.
  void select(Password password) => emit(state.copyWith(selected: password));

  /// Deselect any selected password.
  void deselect() => emit(state.withIdle().copyWith(selected: Password.empty));
}