import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lockie_app/add_password/add_password.dart';
import 'package:lockie_app/menu/menu.dart';
import 'package:lockie_app/passwords/passwords.dart';
import 'package:lockie_theme/lockie_theme.dart';

class PasswordsView extends StatelessWidget {

  const PasswordsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PasswordsCubit, PasswordsState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) async {
          switch(state.status) {
            case PasswordsStatus.error:
              await Fluttertoast.cancel();
              await Fluttertoast.showToast(
                msg: state.errorMessage ?? 'An unknown error has occurred.',
                backgroundColor: Colors.red.withOpacity(0.2)
              );
              break;
            case PasswordsStatus.copied:
              Fluttertoast.showToast(
                msg: 'Password copied to clipboard.', 
                toastLength: Toast.LENGTH_SHORT
              );
              break;
            default:
              break;
          }
        },
        builder: (context, state) {
          return LoadingBackground(
            loading: state.status == PasswordsStatus.loading,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 40),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text('Lockie', style: Theme.of(context).textTheme.headline6),
                        ),
                        LockieIconButton(
                          hasBorder: false,
                          icon: Icons.menu_rounded, 
                          onPressed: () => Navigator.of(context).push(MenuPage.route)
                        )
                      ]
                    ),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      child: state.passwords.isNotEmpty
                      ?ScrollConfiguration(
                        behavior: NoScrollBehavior(),
                        child: ListView.builder(
                          itemCount: state.passwords.length,
                          itemBuilder: (context, index) {
                            final password = state.passwords[index];
                            final selected = state.selected != null && state.selected == password;
                            return PasswordWidget(password, 
                              key: ValueKey(password.id),
                              selected: selected,
                              errored: selected && state.status == PasswordsStatus.error,
                            );
                          }
                        )
                      )
                      :Padding(
                        padding: const EdgeInsets.all(40),
                        child: _buildEmpty(context),
                      )
                    )
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: LockieIconButton(
                        icon: Icons.add,
                        onPressed: () => Navigator.of(context).push(AddPasswordPage.route),
                        size: 32,
                        padding: 16,
                      )
                    )
                  )
                ]
              )
            )
          );
        }
      )
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'You do not have currently any password. Start by ',
            ),
            TextSpan(
              style: TextStyle(
                color: Theme.of(context).textTheme.headline5!.color,
                decoration: TextDecoration.underline
              ),
              text: 'creating your first.',
              recognizer: TapGestureRecognizer()..onTap = () 
              => Navigator.of(context).push(AddPasswordPage.route)
            ),
          ]
        )
      )
    );
  }
}