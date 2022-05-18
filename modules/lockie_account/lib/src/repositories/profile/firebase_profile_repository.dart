import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lockie_account/lockie_account.dart';

class FirebaseProfileRepository implements IProfileRepository {

  final  _collection = FirebaseFirestore.instance.collection('users')
  .withConverter<UserProfile>(
    fromFirestore: (snapshot, _) => UserProfile.fromDocument(snapshot),
    toFirestore: (model, _) => model.toMap()
  );
  late DocumentReference<UserProfile> _document;
  UserProfile _cachedUserProfile = UserProfile.empty;

  @override
  void initialize(String id) {
    _document = _collection.doc(id);
  }

  @override
  Stream<UserProfile> get stream {
    return _document.snapshots().map((snapshot) => _cachedUserProfile = snapshot.data() ?? UserProfile.empty);
  }

  @override
  UserProfile get currentUserProfile {
    return _cachedUserProfile;
  }

  @override
  Future<void> set(UserProfile userProfile) async  {
    await _document.set(userProfile);
  }

  @override
  Future<void> update(Map<String, dynamic> json) async  {
    await _document.update(json);
  }
}