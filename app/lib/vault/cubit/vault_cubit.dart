import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lockie_vault/lockie_vault.dart';

part 'vault_state.dart';

class VaultCubit extends Cubit<VaultState> {

  final IVaultRepository vaultRepository;

  VaultCubit({
    required this.vaultRepository
  }) : super(VaultState.pure()) {
    emit(state.copyWith(keys: vaultRepository.currentKeys));
    vaultRepository.stream.listen((keys) {
      if(!isClosed) {
        emit(state.copyWith(status: VaultStatus.idle, keys: keys));
      }
    });
    vaultRepository.getAll();
  }
}