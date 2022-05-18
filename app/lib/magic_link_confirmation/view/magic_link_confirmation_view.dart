import 'package:flutter/material.dart';
import 'package:lockie_theme/lockie_theme.dart';
import 'package:open_mail_app/open_mail_app.dart';

class MagicLinkConfirmationView extends StatelessWidget {

  const MagicLinkConfirmationView({
    Key? key,
  }) : super(key: key);

  void _openMailApp(BuildContext context) async {
    var result = await OpenMailApp.openMailApp();
    if (!result.didOpen && !result.canOpen) {
      showDialog(context: context, builder: (context) 
        => ErrorDialog('Could not open email app. Please open your default email app manually on this device.')
      );
    } 
    else if (!result.didOpen && result.canOpen) {
      showDialog(context: context, builder: (_) 
        => MailAppPickerDialog(mailApps: result.options),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('You got an email.',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text('Use the link you received on your email to authenticate '
                'into the app and create an account.',
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: LockiePrimaryButton(
                label: Text('Open Email App'),
                onTap: () => _openMailApp(context)
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Make sure you open it from this current device.',
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(flex: 2)
          ]
        )
      )
    );
  }
}