import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:encrypt/encrypt.dart';
import 'package:lockie_app/add_password/add_password.dart';
import 'package:lockie_locker/lockie_locker.dart';
import 'package:lockie_vault/lockie_vault.dart';
import 'package:random_gen/random_gen.dart';

part 'add_password_state.dart';

class AddPasswordCubit extends Cubit<AddPasswordState> {

  IPasswordsRepository passwordsRepository;
  IVaultRepository vaultRepository;

  AddPasswordCubit({
    required this.passwordsRepository,
    required this.vaultRepository
  }) : super(AddPasswordState.pure()) {
    unlockVault();
  }

  String generatePassword() {
    final password = RandomGenerator.password();
    final sequence = SequenceInput.dirty(password);

    emit(state.copyWith(
      sequence: sequence,
      status: Formz.validate([sequence, state.service])
    ));

    return password;
  }

  void submit() async {
    if(state.status.isInvalid) return;
    if(state.selectedKey.isEmpty) return;
    try {
      emit(state.withLoading());
      // Generate a random initialization vector that will be stored remotely.
      final iv = IV.fromSecureRandom(16);

      // Get the key value stored locally by the specified key id.
      final utf8key = await vaultRepository.get(state.selectedKey);
      final key = Key.fromUtf8(utf8key);

      // Encrypt the password sequence with the generated IV and chosen key.
      final encrypted = Encrypter(AES(key)).encrypt(state.sequence.value, iv: iv);

      // Upload encrypted password to our locker.
      await passwordsRepository.add(
        Password(
          service: state.service.value, 
          sequence: encrypted.base64, 
          iv: iv.base64,
          key: state.selectedKey
        )
      );
      emit(state.withSuccess());
    }
    on Exception {
      emit(state.withError('An unknown error has occurred.'));
    }
  }

  void unlockVault() async {
    await vaultRepository.getAll();
    final currentKeys = vaultRepository.currentKeys.keys.toList();
    if(currentKeys.isNotEmpty) {
      emit(state.copyWith(
        selectedKey: currentKeys.first,
        keys: currentKeys
      ));
    }
  }

  void keyChanged(String value) => emit(state.copyWith(selectedKey: value));

  void serviceChanged(String value) {
    final service = ServiceInput.dirty(value);
    emit(state.copyWith(service: service, status: Formz.validate([service, state.sequence])));
  }

  void sequenceChanged(String value) {
    final sequence = SequenceInput.dirty(value);
    emit(state.copyWith(sequence: sequence, status: Formz.validate([sequence, state.service])));
  }

  void obscureTextChanged() => emit(state.copyWith(obscureText: !state.obscureText));
}