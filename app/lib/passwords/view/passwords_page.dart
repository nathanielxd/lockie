import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockie_app/passwords/passwords.dart';
import 'package:lockie_locker/lockie_locker.dart';
import 'package:lockie_vault/lockie_vault.dart';

class PasswordsPage extends StatelessWidget {

  const PasswordsPage({
    Key? key,
  })
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordsCubit(
        passwordsRepository: context.read<FirebasePasswordsRepository>(),
        vaultRepository: context.read<SecureVaultRepository>()
      ),
      child: PasswordsView()
    );
  }
}