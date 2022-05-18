import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lockie_app/add_key/add_key.dart';
import 'package:lockie_vault/lockie_vault.dart';
import 'package:random_gen/random_gen.dart';

part 'add_key_state.dart';

class AddKeyCubit extends Cubit<AddKeyState> {

  final IVaultRepository vaultRepository;

  AddKeyCubit({
    required this.vaultRepository
  }) : super(AddKeyState.pure()) {
    keyChanged(generateKey());
  }

  String generateKey() {
    final generated = RandomGenerator.password(length: 32);

    final keyInput = KeyInput.dirty(generated);

    emit(state.copyWith(
      key: keyInput,
      status: Formz.validate([keyInput, state.id])
    ));

    return generated;
  }

  void submit() async {
    if(!state.id.valid) {
      emit(state.withError('The key id is either invalid or empty. Please enter a valid key id and try again.'));
      return;
    }
    if(!state.key.valid) {
      emit(state.withError('The key value is invalid. Please enter a valid key value and try again. A key should have exactly 32 characters.'));
      return;
    }

    if(!state.status.isValid) {
      emit(state.withError('Something does not look right. Please make sure all fields are valid.'));
      return;
    }

    try {
      emit(state.withLoading());
      await vaultRepository.getAll();
      final doesKeyExist = vaultRepository.currentKeys.containsKey(state.id.value);

      if(doesKeyExist) {
        emit(state.withError('Key with the same ID already exists. Please try again with a different ID.'));
        return;
      }

      await vaultRepository.add(state.id.value, state.key.value);
      await vaultRepository.getAll();
      emit(state.withSuccess());
    }
    on Exception {
      emit(state.withError('An unknown error has occurred.'));
    }
  }

  void idChanged(String value) {
    final id = IdInput.dirty(value);
    emit(state.copyWith(id: id, status: Formz.validate([id, state.key])));
  }

  void keyChanged(String value) {
    final key = KeyInput.dirty(value);
    emit(state.copyWith(key: key, status: Formz.validate([key, state.id])));
  }
}