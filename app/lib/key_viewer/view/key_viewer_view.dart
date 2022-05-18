import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lockie_app/key_viewer/key_viewer.dart';
import 'package:lockie_theme/lockie_theme.dart';

class KeyViewerView extends StatelessWidget {

  const KeyViewerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<KeyViewerCubit, KeyViewerState>(
        listener: (context, state) {
          if(state.copied) {
            Fluttertoast.showToast(msg: 'Key copied to clipboard.');
          }
          switch(state.status) {
            case KeyViewerStatus.deleted:
              Navigator.of(context).pop();
              break;
            case KeyViewerStatus.error:
              showDialog(context: context, builder: (context) => ErrorDialog(state.errorMessage));
              break;
            default:
              break;
          }
        },
        builder: (context, state) {
          return LoadingBackground(
            loading: state.status == KeyViewerStatus.loading,
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
                          child: Text('Key Viewer', style: Theme.of(context).textTheme.headline6),
                        ),
                        SizedBox(width: 30),
                      ]
                    ),
                    SizedBox(height: 30),
                    LockieTextField(
                      labelText: 'KEY ID',
                      readOnly: true,
                      initialValue: state.id,
                    ),
                    DefaultTextStyle.merge(
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Mono',
                        color: Colors.white
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, right: 10),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_forward_ios_sharp),
                                SizedBox(width: 10),
                                Text(state.obscured ? '########' : state.key.substring(0, 8))
                              ]
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, right: 10),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_forward_ios_sharp),
                                SizedBox(width: 10),
                                Text(state.obscured ? '########' : state.key.substring(8, 16))
                              ]
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, right: 10),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_forward_ios_sharp),
                                SizedBox(width: 10),
                                Text(state.obscured ? '########' : state.key.substring(16, 24))
                              ]
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, right: 10),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_forward_ios_sharp),
                                SizedBox(width: 10),
                                Text(state.obscured ? '########' : state.key.substring(24, 32))
                              ]
                            )
                          ),
                        ]
                      ),
                    ),
                    SizedBox(height: 20),
                    LockieTextButton(state.obscured ? 'Reveal Key' : 'Hide Key',
                      leading: Icon(state.obscured ? Icons.visibility_rounded : Icons.visibility_off_rounded), 
                      onTap: () => context.read<KeyViewerCubit>().obscuredChanged()
                    ),
                    LockieTextButton(state.copied ? 'Key Copied!' : 'Copy To Clipboard',
                      leading: Icon(Icons.copy_rounded), 
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: state.key));
                        await context.read<KeyViewerCubit>().copyToClipboard();
                      }
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
                                    TextSpan(text: 'Are you sure you want to delete this key?\n\n'),
                                    TextSpan(text: 'WARNING! ', 
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.red[700]
                                      )
                                    ),
                                    TextSpan(text: 'You will not be able to decrypt your passwords that were encrypted with this key.\n'),
                                  ]
                                )
                              ),
                              options: [
                                LockieTextButton('Confirm deletion',
                                  leading: Icon(Icons.delete_outline_rounded, color: Colors.red[700]),
                                  style: TextStyle(color: Colors.red[700]),
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
                          await context.read<KeyViewerCubit>().delete();
                        }
                      }
                    ),
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