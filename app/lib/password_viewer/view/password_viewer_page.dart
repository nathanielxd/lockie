import 'package:flutter/material.dart';
import 'package:lockie_app/password_viewer/password_viewer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockie_locker/lockie_locker.dart';
import 'package:lockie_vault/lockie_vault.dart';

class PasswordViewerPage extends StatelessWidget {

  final Password password;

  const PasswordViewerPage(this.password, {
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
		return BlocProvider(
      create: (_) => PasswordViewerCubit(
        password: password,
        passwordsRepository: context.read<FirebasePasswordsRepository>(),
        vaultRepository: context.read<SecureVaultRepository>()
      ),
      child: PasswordViewerView()
    );
  }
}
  