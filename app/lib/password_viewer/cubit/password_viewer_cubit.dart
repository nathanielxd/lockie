import 'package:bloc/bloc.dart';
import 'package:encrypt/encrypt.dart';
import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lockie_locker/lockie_locker.dart';
import 'package:lockie_vault/lockie_vault.dart';

part 'password_viewer_state.dart';

class PasswordViewerCubit extends Cubit<PasswordViewerState> {

  final Password password;
  final IPasswordsRepository passwordsRepository;
  final IVaultRepository vaultRepository;

  PasswordViewerCubit({
    required this.password,
    required this.passwordsRepository,
    required this.vaultRepository
  }) : super(PasswordViewerState.pure().copyWith(password: password));

  Future<void> confirmIdentity() async {
    try {
      final localAuth = LocalAuthentication();

      final didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please confirm your identity to manage your secret key.'
      );

      if(didAuthenticate) {
        emit(state.copyWith(confirmedIdentity: true));
      }
    }
    on Exception {
      emit(state.withError('An error occured verifying your identity.'));
    }
  }

  Future<void> decrypt() async {
    try {
      if(!state.confirmedIdentity) {
        await confirmIdentity();
      }

      if(state.confirmedIdentity) {
        // Use the password's stored key id to get the key value from secure local storage.
        final utf8Key = await vaultRepository.get(password.key);
        final key = Key.fromUtf8(utf8Key);

        /// Decrypt the password with the key and return it.
        final decrypted = Encrypter(AES(key))
          .decrypt64(password.sequence, 
            iv: IV.fromBase64(password.iv)
          );
        
        emit(state.copyWith(obscured: false, decrypted: decrypted));
      }
    }
    on VaultException catch(e) {
      emit(state.withError(e.message));
    }
    on Exception {
      emit(state.withError('An unknown error has occurred. Please try again later.'));
    }
  }

  void obscure() => emit(state.copyWith(obscured: true));

  Future<void> delete() async {
    if(!state.confirmedIdentity) {
      await confirmIdentity();
    }

    if(state.confirmedIdentity) {
      try {
        emit(state.withLoading());
        await passwordsRepository.delete(state.password);
        emit(state.withDeleted());
      }
      on Exception {
        emit(state.withError('An unknown error has occurred.'));
      }
    }
  }

}