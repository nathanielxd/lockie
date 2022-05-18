class VaultException implements Exception {

  final String message;
  VaultException(this.message);

  @override
  String toString() {
    return message;
  }
}