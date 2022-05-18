class AuthenticationException implements Exception {
  
  final String message;
  AuthenticationException(this.message);

  /// Create an authentication message from a firebase authentication exception code.
  factory AuthenticationException.fromCode(String code) {
    switch(code) {
      case 'invalid-email': return AuthenticationException('Email is not valid or badly formatted.');
      case 'user-disabled': return AuthenticationException('This user has been disabled. Please contact support for help.');
      case 'user-not-found': return AuthenticationException('We could not find an account. Would you create one instead?');
      case 'wrong-password': return AuthenticationException('We could not find an account. Would you create one instead?');
      case 'email-already-in-use': return AuthenticationException('Unfortunately, an account with this email already exists. Would you log in instead?');
      case 'operation-not-allowed': return AuthenticationException('This operation is not allowed. Please contact support for help.');
      case 'weak-password': return AuthenticationException('We would like to keep you safe but your password is too weak. Please try another one.');
      case 'expired-action-code': return AuthenticationException('That took too long and the session has expired! Please try again.');
      default: return AuthenticationException.unknown();
    }
  }

  /// Checks whether this exception has the same message as an another exception with [code].
  bool isSameAs(String code) => message == AuthenticationException.fromCode(code).message;

  /// An authentication error displaying the message "An unknown error has occured."
  factory AuthenticationException.unknown() => AuthenticationException('An unknown error has occured.');

  @override
  String toString() => message;
}