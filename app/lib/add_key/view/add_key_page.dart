import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockie_app/add_key/add_key.dart';
import 'package:lockie_theme/lockie_theme.dart';
import 'package:lockie_vault/lockie_vault.dart';

class AddKeyPage extends StatelessWidget {

  const AddKeyPage({
    Key? key,
  }) : super(key: key);

  static PageRoute get route => LockiePageRoute(builder: (context) => AddKeyPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddKeyCubit(
        vaultRepository: context.read<SecureVaultRepository>()
      ),
      child: AddKeyView()
    );
  }
}