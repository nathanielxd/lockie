import 'package:flutter/material.dart';
import 'package:lockie_app/account/account.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
		return BlocProvider(
      create: (_) => AccountCubit(),
      child: AccountView()
    );
  }
}
  