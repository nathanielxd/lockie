import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockie_app/key_viewer/key_viewer.dart';
import 'package:lockie_theme/lockie_theme.dart';
import 'package:lockie_vault/lockie_vault.dart';

class KeyViewerPage extends StatelessWidget {

  final String id;
  final String value;

  const KeyViewerPage({
    required this.id,
    required this.value,
    Key? key,
  }) : super(key: key);

  static PageRoute route(String id, String value) 
  => LockiePageRoute(builder: (_) => KeyViewerPage(id: id, value: value));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => KeyViewerCubit(
        id: id,
        value: value,
        vaultRepository: context.read<SecureVaultRepository>()
      ),
      child: KeyViewerView()
    );
  }
}