import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lockie_locker/lockie_locker.dart';

class FirebasePasswordsRepository implements IPasswordsRepository {

  final  _usersCollection = FirebaseFirestore.instance.collection('users');
  late CollectionReference<Password>? _collection;
  List<Password> _cachedPasswords = [];

  @override
  void initialize(String userId) {
    _collection = _usersCollection.doc(userId).collection('locker')
    .withConverter<Password>(
      fromFirestore: (snapshot, _) => Password.fromDocument(snapshot),
      toFirestore: (model, _) => model.toMap()
    );
  }

  @override
  Stream<List<Password>> get stream {
    return _collection!.snapshots().map((snapshot) => _cachedPasswords = snapshot.docs.map((e) => e.data()).toList());
  }

  @override
  List<Password> get currentPasswords {
    return _cachedPasswords;
  }

  @override
  Future<void> add(Password password) async  {
    await _collection!.add(password);
  }

  @override
  Future<void> set(Password password) async  {
    await _collection!.doc(password.id).set(password);
  }

  @override
  Future<void> update(String id, Map<String, dynamic> json) async  {
    await _collection!.doc(id).update(json);
  }

  @override
  Future<void> delete(Password password) async  {
    await _collection!.doc(password.id).delete();
  }
}