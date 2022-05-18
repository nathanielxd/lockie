import 'package:lockie_locker/lockie_locker.dart';

abstract class IPasswordsRepository  {
  /// Initialize this repository with an user id.
  void initialize(String userId);
  /// Get a stream of all passwords data in a list.
  Stream<List<Password>> get stream;
  /// Get the current cached list of passwords.
  List<Password> get currentPasswords;
  /// Add a new password to the collection and update [stream].
  Future<void> add(Password password);
  /// Set a password with the id of [password] and update [stream].
  Future<void> set(Password password);
  /// Update a password with [id].
  Future<void> update(String id, Map<String, dynamic> json);
  /// Delete a password with the id of [password] and update [stream].
  Future<void> delete(Password password);
}