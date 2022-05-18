import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {

  final String? message;
  const ErrorDialog(this.message, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.close,
              size: 40,
              color: Theme.of(context).errorColor
            ),
            SizedBox(height: 20),
            Text(message ?? 'An unknown error has occurred.',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Manrope'
              )
            )
          ]
        )
      )
    );
  }
}