abstract class IVaultRepository  {
  /// Get a stream containing a map of currently stored keys.
  Stream<Map<String, String>> get stream;
  /// Get cached map of stored keys.
  Map<String, String> get currentKeys;
  /// Read local disk and get a map of all stored keys.
  Future<Map<String, String>> getAll();
  /// Decrypt and return the value of a key with an identification of [id].
  /// 
  /// Throws an exception if id could not be found.
  Future<String> get(String id);
  /// Add a new key to the local storage.
  Future<void> add(String id, String value);
  /// Delete a key with the id of [id].
  Future<void> delete(String id);
}