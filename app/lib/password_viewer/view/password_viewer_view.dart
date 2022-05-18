import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lockie_app/password_viewer/password_viewer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockie_theme/lockie_theme.dart';

class PasswordViewerView extends StatelessWidget {

  const PasswordViewerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PasswordViewerCubit, PasswordViewerState>(
        listener: (context, state) {
          switch(state.status) {
            case PasswordViewerStatus.deleted:
              Navigator.of(context).pop();
              break;
            case PasswordViewerStatus.error:
              showDialog(context: context, builder: (context) => ErrorDialog(state.errorMessage));
              break;
            default:
              break;
          }
        },
        builder: (context, state) {
          return LoadingBackground(
            loading: state.status == PasswordViewerStatus.loading,
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
                          child: Text('Password Viewer', style: Theme.of(context).textTheme.headline6),
                        ),
                        SizedBox(width: 30),
                      ]
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: SingleChildScrollView(
                        child: DefaultTextStyle.merge(
                          style: TextStyle(
                            fontSize: 18
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LockieTextField(
                                labelText: 'SERVICE',
                                readOnly: true,
                                initialValue: state.password.service,
                              ),
                              SizedBox(height: 30),
                              LockieTextField(
                                labelText: 'PASSWORD',
                                key: ValueKey(state.obscured),
                                readOnly: true,
                                initialValue: state.obscured ? '••••••••' : state.decrypted,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Mono'
                                ),
                              ),
                              SizedBox(height: 5),
                              LockieTextButton(state.obscured ? 'Reveal Password' : 'Hide Password',
                                leading: Icon(state.obscured ? Icons.visibility_rounded : Icons.visibility_off_rounded), 
                                onTap: () {
                                  if(state.obscured) {
                                    context.read<PasswordViewerCubit>().decrypt();
                                  }
                                  else {
                                    context.read<PasswordViewerCubit>().obscure();
                                  }
                                }
                              ),
                              SizedBox(height: 20),
                              LockieTextField(
                                labelText: 'ENCRYPTED WITH KEY',
                                readOnly: true,
                                initialValue: state.password.key,
                              ),
                              SizedBox(height: 20),
                              LockieTextButton('Delete',
                                leading: Icon(Icons.delete_outline_rounded, color: Colors.red[700]),
                                style: TextStyle(color: Colors.red[700]), 
                                borderColor: Colors.red[700],
                                onTap: () async {
                                  final result = await showDialog<bool>(
                                    context: context,
                                    builder: (context) {
                                      return LockieDialog(
                                        content: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: 'Are you sure you want to delete this password?\n\n'),
                                            ]
                                          )
                                        ),
                                        options: [
                                          LockieTextButton('Confirm deletion',
                                            leading: Icon(Icons.delete_outline_rounded, color: Colors.red[700]),
                                            style: TextStyle(
                                              color: Colors.red[700]
                                            ),
                                            borderColor: Colors.red[700],
                                            onTap: () => Navigator.of(context).pop(true)
                                          ),
                                          SizedBox(height: 10),
                                          LockieTextButton('Cancel', 
                                            leading: Icon(Icons.arrow_back_rounded),
                                            onTap: () => Navigator.of(context).pop(false)
                                          )
                                        ],
                                      );
                                    }
                                  );

                                  if(result != null && result) {
                                    await context.read<PasswordViewerCubit>().delete();
                                  }
                                }
                              ),
                            ]
                          ),
                        )
                      )
                    )
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