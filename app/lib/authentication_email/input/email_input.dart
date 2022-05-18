import 'package:formz/formz.dart';

class EmailInput extends FormzInput<String, String> {

  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

  @override
  String? validator(String? value) {
    if(value == null || value.isEmpty) return 'This field is required.';
    if(!_emailRegExp.hasMatch(value)) return 'Email is not valid.';
    return null;
  }
}