import 'package:flutter/material.dart';

class LockiePrimaryButton extends StatelessWidget {

  final Widget label;
  final void Function() onTap;

  const LockiePrimaryButton({ 
    Key? key,
    required this.label,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: Theme.of(context).textTheme.button,
      child: Material(
        color: Color(0xff1c1c1c),
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: label
            )
          )
        )
      )
    );
  }
}