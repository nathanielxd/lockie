import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockie_app/app/app.dart';
import 'package:lockie_app/authentication_email/authentication_email.dart';
import 'package:lockie_app/passwords/passwords.dart';
import 'package:lockie_theme/lockie_theme.dart';

class AppView extends StatelessWidget {

  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lockie',
      theme: LockieThemes.dark,
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          switch(state) {
            case AppState.loading:
              return LoadingBackground(
                loading: true,
                child: Container(color: Colors.black),
              );
            case AppState.unauthenticated:
              return AuthenticationEmailPage();
            case AppState.authenticated:
              return PasswordsPage();
          }
        }
      )
    );
  }
}