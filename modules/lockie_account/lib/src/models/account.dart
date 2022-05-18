import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Account extends Equatable {

  final String id;
  final String email;
  final bool emailVerified;
  final String phoneNumber;

  const Account({
    required this.id,
    required this.email,
    required this.emailVerified,
    required this.phoneNumber,
  });

  static const empty = Account(id: '', email: '', emailVerified: false, phoneNumber: '');
  bool get isEmpty => this == empty;

  Account copyWith({
    String? id,
    String? email,
    bool? emailVerified,
    String? phoneNumber,
  }) => Account(
    id: id ?? this.id,
    email: email ?? this.email,
    emailVerified: emailVerified ?? this.emailVerified,
    phoneNumber: phoneNumber ?? this.phoneNumber,
  );

  factory Account.fromFirebase(User user)
  => Account(
    id: user.uid,
    email: user.email ?? '',
    emailVerified: user.emailVerified,
    phoneNumber: user.phoneNumber ?? ''
  );

  @override
  List<Object?> get props => [id, email, emailVerified, phoneNumber];
}