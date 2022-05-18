import 'package:flutter/material.dart';

class LockieIconButton extends StatelessWidget {

  final IconData icon;
  final void Function() onPressed;
  final double size;
  final double padding;
  final bool hasBorder;

  const LockieIconButton({ 
    Key? key,
    required this.icon,
    required this.onPressed,
    this.size = 24,
    this.padding = 8,
    this.hasBorder = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      child: Material(
        color: Colors.transparent,
        shape: CircleBorder(
          side: hasBorder 
          ?BorderSide(
            color: Colors.white,
            width: 0.5
          )
          :BorderSide.none
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Icon(icon, size: size),
        ),
      ),
      onTap: onPressed,
    );
  }
}