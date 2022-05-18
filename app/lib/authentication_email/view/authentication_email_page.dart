import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockie_account/lockie_account.dart';
import 'package:lockie_app/authentication_email/authentication_email.dart';

class AuthenticationEmailPage extends StatelessWidget {

  const AuthenticationEmailPage({
    Key? key,
  })
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthenticationEmailCubit(
        authenticationRepository: context.read<FirebaseAuthenticationRepository>()
      ),
      child: AuthenticationEmailView()
    );
  }
}