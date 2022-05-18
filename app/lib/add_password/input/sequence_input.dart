import 'package:formz/formz.dart';

class SequenceInput extends FormzInput<String, String> {

  const SequenceInput.pure() : super.pure('');
  const SequenceInput.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if(value == null || value.isEmpty) return 'This field is required.';
    return null;
  }
}