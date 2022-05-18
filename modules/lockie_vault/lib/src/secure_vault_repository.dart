import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lockie_vault/lockie_vault.dart';

class SecureVaultRepository implements IVaultRepository {

  final _storage = FlutterSecureStorage();
  final _controller = StreamController<Map<String, String>>.broadcast();
  Map<String, String> _cachedKeys = {};

  @override
  Stream<Map<String, String>> get stream => _controller.stream;

  @override
  Map<String, String> get currentKeys => _cachedKeys;

  @override
  Future<Map<String, String>> getAll() async {
    final allKeys = await _storage.readAll();
    _controller.add(_cachedKeys = allKeys);
    return allKeys;
  }

  @override
  Future<String> get(String id) async {
    final value = await _storage.read(key: id);
    if(value == null) {
      throw VaultException('Error retriving key value as no key with id ' + id + ' was found stored locally.');
    }
    return value;
  }

  @override
  Future<void> add(String id, String value) async {
    await _storage.write(key: id, value: value);
  }

  @override
  Future<void> delete(String id) async {
    await _storage.delete(key: id);
  }
}