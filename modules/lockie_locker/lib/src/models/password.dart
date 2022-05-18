import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Password extends Equatable {

  final String id;
  final String service;
  final String sequence;
  final String iv;
  final String key;

  const Password({
    this.id = '',
    required this.service,
    required this.sequence,
    required this.iv,
    required this.key,
  });

  static const empty = Password(id: '', service: '', sequence: '', iv: '', key: '');
  bool get isEmpty => this == empty;

  Password copyWith({
    String? id,
    String? service,
    String? sequence,
    String? iv,
    String? key,
  }) => Password(
    id: id ?? this.id,
    service: service ?? this.service,
    sequence: sequence ?? this.sequence,
    iv: iv ?? this.iv,
    key: key ?? this.key
  );

  Map<String, dynamic> toMap() => {
    'service': service,
    'sequence': sequence,
    'iv': iv,
    'key': key
  };

  factory Password.fromMap(Map<String, dynamic> map)
  => Password(
    id: map['id'] ?? '',
    service: map['service'],
    sequence: map['sequence'],
    iv: map['iv'],
    key: map['key']
  );

  factory Password.fromDocument(DocumentSnapshot<Map<String, dynamic>> snapshot)
  => Password.fromMap(snapshot.data()!).copyWith(id: snapshot.id);

  @override
  List<Object?> get props => [id, service, sequence, iv, key];
}