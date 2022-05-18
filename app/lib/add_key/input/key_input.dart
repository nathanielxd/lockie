import 'package:formz/formz.dart';

class KeyInput extends FormzInput<String, String> {

  const KeyInput.pure() : super.pure('');
  const KeyInput.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if(value == null || value.isEmpty) return 'This field is required.';
    if(value.length != 32) return 'Requires an exact length of 32 characters.';
    return null;
  }
}