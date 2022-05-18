import 'package:flutter/material.dart';

class LockieTextButton extends StatelessWidget {

  final String text;
  final void Function() onTap;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? style;
  final Color? borderColor;

  const LockieTextButton(this.text, { 
    Key? key,
    required this.onTap,
    this.leading,
    this.trailing,
    this.style,
    this.borderColor
  }) : super(key: key);

  static final _defaultTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.grey[300]
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: borderColor ?? Colors.grey[300]!)
                )
              ),
              child: DefaultTextStyle.merge(
                style: style != null ? _defaultTextStyle.merge(style) : _defaultTextStyle,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: trailing != null || leading != null
                  ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(leading != null) leading!,
                      if(leading != null) SizedBox(width: 4),
                      Text(text),
                      if(trailing != null) SizedBox(width: 4),
                      if(trailing != null) trailing!
                    ],
                  )
                  : Text(text)
                )
              ),
            )
          ],
        )
      ),
      onTap: onTap,
    );
  }
}