import 'package:equatable/equatable.dart';

class EmailPreferences extends Equatable {

  final DateTime? lastRateInquiry;
  final bool canReceiveRateInquiry;

  const EmailPreferences({
    this.lastRateInquiry,
    required this.canReceiveRateInquiry,
  });

  static const empty = EmailPreferences(canReceiveRateInquiry: false);
  bool get isEmpty => this == empty;

  EmailPreferences copyWith({
    DateTime? lastRateInquiry,
    bool? canReceiveRateInquiry,
  }) => EmailPreferences(
    lastRateInquiry: lastRateInquiry ?? this.lastRateInquiry,
    canReceiveRateInquiry: canReceiveRateInquiry ?? this.canReceiveRateInquiry,
  );

  Map<String, dynamic> toMap() => {
    'canReceiveRateInquiry': canReceiveRateInquiry,
  };

  factory EmailPreferences.fromMap(Map<String, dynamic> map)
  => EmailPreferences(
    lastRateInquiry: DateTime.fromMillisecondsSinceEpoch(map['lastRateInquiry'] ?? 0),
    canReceiveRateInquiry: map['canReceiveRateInquiry'],
  );

  @override
  List<Object?> get props => [lastRateInquiry, canReceiveRateInquiry];
}