import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lockie_account/lockie_account.dart';

class UserProfile extends Equatable {

  final String id;
  final String email;
  final DateTime? lastActive;
  final EmailPreferences emailPreferences;

  const UserProfile({
    required this.id,
    required this.email,
    this.lastActive,
    required this.emailPreferences,
  });

  static const empty = UserProfile(id: '', email: '', emailPreferences: EmailPreferences.empty);
  bool get isEmpty => this == empty;

  UserProfile copyWith({
    String? id,
    String? email,
    DateTime? lastActive,
    EmailPreferences? emailPreferences,
  }) => UserProfile(
    id: id ?? this.id,
    email: email ?? this.email,
    lastActive: lastActive ?? this.lastActive,
    emailPreferences: emailPreferences ?? this.emailPreferences,
  );

  Map<String, dynamic> toMap() => {
    'email': email,
    'emailPreferences': emailPreferences.toMap(),
  };

  factory UserProfile.fromMap(Map<String, dynamic> map)
  => UserProfile(
    id: map['id'] ?? '',
    email: map['email'],
    lastActive: DateTime.fromMillisecondsSinceEpoch(map['lastActive'] ?? 0),
    emailPreferences: EmailPreferences.fromMap(map['emailPreferences']),
  );

  factory UserProfile.fromDocument(DocumentSnapshot<Map<String, dynamic>> snapshot)
  => UserProfile.fromMap(snapshot.data()!).copyWith(id: snapshot.id);

  @override
  List<Object?> get props => [id, email, lastActive, emailPreferences];
}