import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lockie_vault/lockie_vault.dart';

part 'key_viewer_state.dart';

class KeyViewerCubit extends Cubit<KeyViewerState> {

  final String id;
  final String value;
  final IVaultRepository vaultRepository;

  KeyViewerCubit({
    required this.id,
    required this.value,
    required this.vaultRepository
  }) : super(KeyViewerState.pure().copyWith(id: id, key: value));

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

  Future<void> obscuredChanged() async {
    if(!state.confirmedIdentity) {
      await confirmIdentity();
    }
    
    if(state.confirmedIdentity) {
      emit(state.copyWith(obscured: !state.obscured));
    }
  }

  Future<void> copyToClipboard() async {
    if(!state.confirmedIdentity) {
      await confirmIdentity();
    }

    if(state.confirmedIdentity) {
      if(state.copied) {
        emit(state.copyWith(copied: false));
        return;
      }

      emit(state.copyWith(copied: true));
      await Future.delayed(Duration(seconds: 2));
      emit(state.copyWith(copied: false));
    }
  }

  Future<void> delete() async {
    if(!state.confirmedIdentity) {
      await confirmIdentity();
    }

    if(state.confirmedIdentity) {
      try {
        emit(state.copyWith(status: KeyViewerStatus.loading));
        await vaultRepository.delete(state.id);
        await vaultRepository.getAll();
        emit(state.copyWith(status: KeyViewerStatus.deleted));
      }
      on Exception {
        emit(state.copyWith(status: KeyViewerStatus.error, errorMessage: 'An unknown error has occurred.'));
      }
    }
  }
}