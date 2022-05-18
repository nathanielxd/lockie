import 'package:flutter/material.dart';

class LockieTextField extends StatelessWidget {

  final String? labelText;
  final String? hintText;
  final String? errorText;
  final bool readOnly;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final AutovalidateMode autovalidateMode;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final bool hideBorder;
  final TextStyle? style;

  const LockieTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.controller,
    this.focusNode,
    this.onTap,
    this.readOnly = false,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.autofillHints,
    this.keyboardType,
    this.onFieldSubmitted,
    this.textInputAction,
    this.obscureText = false,
    this.suffixIcon,
    this.suffix,
    this.prefix,
    this.initialValue,
    this.errorText,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.hideBorder = false,
    this.style
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      autovalidateMode: autovalidateMode,
      initialValue: initialValue,
      cursorColor: Colors.grey[400],
      style: style == null ? TextStyle(
        color: Colors.grey[300],
        fontWeight: FontWeight.w600,
      ) : style,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(5),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 18,
          color: Colors.grey[700],
          fontWeight: FontWeight.w300,
          fontFamily: 'Manrope'
        ),
        hintStyle: TextStyle(
          color: Colors.grey[800],
          fontFamily: 'Manrope'
        ),
        hintText: hintText,
        errorText: errorText,
        errorStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: Color.fromARGB(255, 172, 41, 32)
        ),
        suffixIcon: suffixIcon,
        suffix: suffix,
        prefix: prefix,
        border: hideBorder ? InputBorder.none : null,
        disabledBorder: hideBorder ? InputBorder.none : null,
        enabledBorder: hideBorder ? InputBorder.none : null,
        errorBorder: hideBorder ? InputBorder.none : null,
        focusedBorder: hideBorder ? InputBorder.none : null,
        focusedErrorBorder: hideBorder ? InputBorder.none : null,
      ),
      onTap: onTap,
      onChanged: onChanged,
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
    );
  }
}