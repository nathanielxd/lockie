import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockie_app/magic_link_confirmation/magic_link_confirmation.dart';

class MagicLinkConfirmationPage extends StatelessWidget {

  const MagicLinkConfirmationPage({
    Key? key,
  })
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MagicLinkConfirmationCubit(),
      child: MagicLinkConfirmationView()
    );
  }
}