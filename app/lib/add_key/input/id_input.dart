import 'package:formz/formz.dart';

class IdInput extends FormzInput<String, String> {

  const IdInput.pure() : super.pure('');
  const IdInput.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if(value == null || value.isEmpty) return 'This field is required.';
    if(value.length > 16) return 'Maximum length is 16 characters.';
    return null;
  }
}