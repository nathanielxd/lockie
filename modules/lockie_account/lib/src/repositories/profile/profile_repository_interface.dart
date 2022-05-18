import 'package:lockie_account/lockie_account.dart';

abstract class IProfileRepository  {
  /// Initialize this repository with a User profile id.
  void initialize(String id);
  /// Get a stream of the current User profile data.
  Stream<UserProfile> get stream;
  /// Get the current User profile cached data.
  UserProfile get currentUserProfile;
  /// Set the current User profile data and update [stream].
  Future<void> set(UserProfile userProfile);
  /// Update the current User profile data and update [stream].
  Future<void> update(Map<String, dynamic> json);
}