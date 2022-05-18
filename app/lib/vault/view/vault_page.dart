import 'package:flutter/material.dart';
import 'package:lockie_app/vault/vault.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockie_vault/lockie_vault.dart';

class VaultPage extends StatelessWidget {

  const VaultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
		return BlocProvider(
      create: (_) => VaultCubit(
        vaultRepository: context.read<SecureVaultRepository>()
      ),
      child: VaultView()
    );
  }
}
  