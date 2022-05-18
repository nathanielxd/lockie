part of 'add_password_cubit.dart';

class AddPasswordState extends Equatable {

  final ServiceInput service;
  final SequenceInput sequence;
  final List<String> keys;
  final String selectedKey;
  final bool obscureText;
  final FormzStatus status;
  final String? errorMessage;

  const AddPasswordState({
    required this.service,
    required this.sequence,
    required this.keys,
    required this.selectedKey,
    required this.obscureText,
    required this.status,
    this.errorMessage,
  });

  factory AddPasswordState.pure()
  => const AddPasswordState(
    service: ServiceInput.pure(),
    sequence: SequenceInput.pure(),
    keys: [],
    selectedKey: '',
    obscureText: false,
    status: FormzStatus.pure,
  );

  double get entropy {
    final s = sequence.valid ? sequence.value : '';
    int pool = 0;

    if(s.contains(RegExp(r'[a-z]'))) pool += 26;
    if(s.contains(RegExp(r'[A-Z]'))) pool += 26;
    if(s.contains(RegExp(r'[0-9]'))) pool += 10;
    if(s.contains(RegExp(r'[!@#\$%\^&\*\(\)=_\+~`,\.\/\?><]'))) pool += 30;

    final power = math.pow(pool, s.length);
    var _power;

    if(power.isNegative || power.isNaN || power.isInfinite) {
      _power = double.maxFinite;
    }
    else {
      _power = power;
    }

    return math.log(_power) / math.log(2);
  }

  AddPasswordState copyWith({
    ServiceInput? service,
    SequenceInput? sequence,
    List<String>? keys,
    String? selectedKey,
    bool? obscureText,
    FormzStatus? status,
    String? errorMessage,
  }) => AddPasswordState(
    service: service ?? this.service,
    sequence: sequence ?? this.sequence,
    keys: keys ?? this.keys,
    selectedKey: selectedKey ?? this.selectedKey,
    obscureText: obscureText ?? this.obscureText,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  AddPasswordState withLoading() => copyWith(status: FormzStatus.submissionInProgress);
  AddPasswordState withSuccess() => copyWith(status: FormzStatus.submissionSuccess);
  AddPasswordState withError(String? errorMessage) => copyWith(status: FormzStatus.submissionFailure, errorMessage: errorMessage);

  @override
  List<Object?> get props => [service, sequence, selectedKey, obscureText, status, errorMessage];
}
