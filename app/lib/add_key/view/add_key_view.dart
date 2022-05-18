import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lockie_app/add_key/add_key.dart';
import 'package:lockie_theme/lockie_theme.dart';

class AddKeyView extends StatefulWidget {

  const AddKeyView({
    Key? key,
  }) : super(key: key);

  @override
  State<AddKeyView> createState() => _AddKeyViewState();
}

class _AddKeyViewState extends State<AddKeyView> {

  final _keyController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _keyController.text = context.read<AddKeyCubit>().state.key.value;
  }

  @override
  void dispose() {
    _keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AddKeyCubit, AddKeyState>(
        listener: (context, state) {
          switch(state.status) {
            case FormzStatus.submissionSuccess:
              Navigator.of(context).pop();
              break;
            case FormzStatus.submissionFailure:
              showDialog(context: context, builder: (context) => LockieDialog(content: Text(state.errorMessage ?? 'An unknown error has occurred.')));
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
                          child: Text('Create Secret Key', style: Theme.of(context).textTheme.headline6),
                        ),
                        SizedBox(width: 35),
                      ]
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LockieTextField(
                              labelText: 'ID',
                              hintText: 'socials',
                              errorText: state.id.invalid ? state.id.error : null,
                              onChanged: (value) => context.read<AddKeyCubit>().idChanged(value),
                            ),
                            SizedBox(height: 30),
                            LockieTextField(
                              labelText: 'KEY',
                              errorText: state.key.invalid ? state.key.error : null,
                              controller: _keyController,
                              onChanged: (value) => context.read<AddKeyCubit>().keyChanged(value),
                              style: TextStyle(
                                fontFamily: 'Mono'
                              ),
                            ),
                            LockieTextButton('Generate a Key', 
                              leading: Icon(Icons.shuffle_rounded),
                              onTap: () => _keyController.text = context.read<AddKeyCubit>().generateKey()
                            ),
                            SizedBox(height: 30),
                            LockieTextButton('Save Key into Vault', 
                              style: TextStyle(
                                fontWeight: FontWeight.w700
                              ),
                              leading: Icon(Icons.lock_rounded),
                              onTap: () => context.read<AddKeyCubit>().submit()
                            )
                          ],
                        ),
                      ),
                    ),
                  ]
                ),
              )
            ),
          );
        }
      )
    );
  }
}