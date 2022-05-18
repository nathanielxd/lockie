import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lockie_app/add_password/add_password.dart';
import 'package:lockie_theme/lockie_theme.dart';

class AddPasswordView extends StatelessWidget {

  AddPasswordView({
    Key? key,
  }) : super(key: key);

  final _sequenceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AddPasswordCubit, AddPasswordState>(
        listener: (context, state) {
          switch(state.status) {
            case FormzStatus.submissionSuccess:
              Navigator.of(context).pop();
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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LockieIconButton(
                          icon: Icons.close, 
                          onPressed: () => Navigator.of(context).pop()
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text('Add New Password', style: Theme.of(context).textTheme.headline6),
                        ),
                        SizedBox(width: 30),
                      ]
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LockieTextField(
                              labelText: 'WEBSITE',
                              errorText: state.service.invalid ? state.service.error : null,
                              onChanged: (value) => context.read<AddPasswordCubit>().serviceChanged(value),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: LockieTextField(
                                controller: _sequenceController,
                                labelText: 'PASSWORD',
                                errorText: state.sequence.invalid ? state.sequence.error : null,
                                obscureText: state.obscureText,
                                onChanged: (value) => context.read<AddPasswordCubit>().sequenceChanged(value),
                                style: TextStyle(
                                  fontFamily: 'Mono',
                                  fontSize: 20
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            LockieTextButton(state.obscureText ? 'Reveal Password' : 'Hide Password',
                              leading: Icon(state.obscureText ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                              onTap: () => context.read<AddPasswordCubit>().obscureTextChanged()
                            ),
                            SizedBox(height: 5),
                            LockieTextButton(
                              'Generate a Password',
                              leading: Icon(Icons.shuffle_rounded),
                              onTap: () => _sequenceController.text = context.read<AddPasswordCubit>().generatePassword()
                            ),
                            /*
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: LockieTextField(
                                key: ValueKey(state.entropy),
                                initialValue: state.entropy.toStringAsFixed(1),
                                readOnly: true,
                                labelText: 'PASSWORD STRENGTH (ENTROPY)',
                              ),
                            ),*/
                            SizedBox(height: 30),
                            Text('ENCRYPTION KEY', 
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w300
                              )
                            ),
                            DropdownButton<String>(
                              isExpanded: true,
                              elevation: 0,
                              underline: Container(
                                height: 1, 
                                width: double.infinity,
                                color: Colors.grey[800],
                              ),
                              value: state.selectedKey,
                              items: state.keys.map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text('# ' + e, 
                                    style: TextStyle(
                                      color: Colors.grey[300],
                                      fontWeight: FontWeight.w600
                                    )
                                  )
                                )
                              ).toList(),
                              onChanged: (value) => context.read<AddPasswordCubit>().keyChanged(value!),
                            ),
                            SizedBox(height: 30),
                            LockieTextButton('Save Password into Lockie',
                              style: TextStyle(
                                fontWeight: FontWeight.w700
                              ),
                              leading: Icon(Icons.lock_rounded),
                              onTap: () => context.read<AddPasswordCubit>().submit()
                            )
                          ]
                        )
                      )
                    )
                  ]
                )
              )
            )
          );
        }
      )
    );
  }
}