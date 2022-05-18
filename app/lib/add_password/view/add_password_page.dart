import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockie_app/add_password/add_password.dart';
import 'package:lockie_locker/lockie_locker.dart';
import 'package:lockie_theme/lockie_theme.dart';
import 'package:lockie_vault/lockie_vault.dart';

class AddPasswordPage extends StatelessWidget {

  const AddPasswordPage({
    Key? key,
  }) : super(key: key);

  static get route => LockiePageRoute(builder: ((context) => AddPasswordPage()));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddPasswordCubit(
        passwordsRepository: context.read<FirebasePasswordsRepository>(),
        vaultRepository: context.read<SecureVaultRepository>()
      ),
      child: AddPasswordView()
    );
  }
}