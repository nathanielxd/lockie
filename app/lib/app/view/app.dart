import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockie_account/lockie_account.dart';
import 'package:lockie_app/app/app.dart';
import 'package:lockie_locker/lockie_locker.dart';
import 'package:lockie_vault/lockie_vault.dart';

class App extends StatelessWidget {
  
  final String? authenticationLink;

  App({
    Key? key,
    this.authenticationLink
  }) : super(key: key);

  final _authenticationRepository = FirebaseAuthenticationRepository();
  final _profileRepository = FirebaseProfileRepository();
  final _passwordsRepository = FirebasePasswordsRepository();
  final _vaultRepository = SecureVaultRepository();

  @override
  Widget build(BuildContext context) {
		return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _profileRepository),
        RepositoryProvider.value(value: _passwordsRepository),
        RepositoryProvider.value(value: _vaultRepository)
      ],
      child: BlocProvider(
        create: (_) => AppCubit(
          authenticationRepository: _authenticationRepository,
          passwordsRepository: _passwordsRepository,
          profileRepository: _profileRepository,
          authenticationLink: authenticationLink
        ),
        child: AppView(),
      )
    );
  }
}