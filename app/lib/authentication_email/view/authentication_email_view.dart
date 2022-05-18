import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lockie_app/authentication_email/authentication_email.dart';
import 'package:lockie_app/magic_link_confirmation/magic_link_confirmation.dart';
import 'package:lockie_theme/lockie_theme.dart';

class AuthenticationEmailView extends StatelessWidget {
  const AuthenticationEmailView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationEmailCubit, AuthenticationEmailState>(
        listener: (context, state) {
          switch(state.status) {
            case FormzStatus.submissionSuccess:
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) => MagicLinkConfirmationPage())));
              break;
            case FormzStatus.submissionFailure:
              showDialog(context: context, builder: (context) => ErrorDialog(state.errorMessage));
              break;
            default:
              break;
          }
        },
        builder: (context, state) {
          return LoadingBackground(
            loading: state.status.isSubmissionInProgress,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Spacer(),
                  Center(
                    child: Text('Lockie.', style: Theme.of(context).textTheme.headline4)
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: LockieTextField(
                      labelText: 'EMAIL',
                      errorText: state.email.invalid ? state.email.error : null,
                      onChanged: (value) => context.read<AuthenticationEmailCubit>().emailChanged(value),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: LockiePrimaryButton(
                      label: Text('Continue'),
                      onTap: () => context.read<AuthenticationEmailCubit>().submit()
                    ),
                  ),
                  Spacer(flex: 2)
                ]
              )
            ),
          );
        }
      )
    );
  }
}
