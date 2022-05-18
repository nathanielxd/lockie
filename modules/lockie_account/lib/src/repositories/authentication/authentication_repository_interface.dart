import 'package:lockie_account/lockie_account.dart';

abstract class IAuthenticationRepository  {
  /// Stream of the currently authenticated account.
  Stream<Account> get stream;
  /// Get the currently cached account.
  Account get currentAccount;
  /// Send a magic link email to an user.
  Future<void> sendMagicLink(String email);
  /// Authenticate an user with a received magic link, updating [stream].
  Future<void> authenticateWithLink(String link);
  /// Log out any currently authenticated account and update [stream] with an empty object.
  Future<void> logout();
}