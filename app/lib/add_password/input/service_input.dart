import 'package:formz/formz.dart';

class ServiceInput extends FormzInput<String, String> {

  const ServiceInput.pure() : super.pure('');
  const ServiceInput.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if(value == null || value.isEmpty) return 'This field is required.';
    if(value.length > 32) return 'Value cannot be larger than 32 characters.';
    return null;
  }
}