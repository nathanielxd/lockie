import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:lockie_account/lockie_account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthenticationRepository implements IAuthenticationRepository {

  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFunctions = FirebaseFunctions.instanceFor(region: 'europe-west3');
  final _firebaseLinks = FirebaseDynamicLinks.instance;

  final  _controller = StreamController<Account>.broadcast()..add(Account.empty);
  User? _cachedUser;
  Account _cachedAccount = Account.empty;

  FirebaseAuthenticationRepository() {
    _firebaseAuth.userChanges().listen((user) {
      _controller.add(_cachedAccount = (user != null) ? Account.fromFirebase(_cachedUser = user) : Account.empty);
    });
    _firebaseLinks.onLink.listen((linkData) { 
      final deepLink = linkData.link;
      print(deepLink.toString());
    });
  }

  @override
  Stream<Account> get stream => _controller.stream;

  @override
  Account get currentAccount => _cachedAccount;

  @override
  Future<void> sendMagicLink(String email) async  {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('lastSignedEmail', email);
      final callable = _firebaseFunctions.httpsCallable('account-authenticateWithEmailLink');
      await callable.call(email);
    }
    on FirebaseAuthException catch (e) {
      throw AuthenticationException.fromCode(e.code);
    }
    on Exception {
      throw AuthenticationException.unknown();
    }
  }

  @override
  Future<void> authenticateWithLink(String link) async {
     // Get cached email stored on disk.
    final prefs = await SharedPreferences.getInstance();
    final cachedEmail = prefs.getString('lastSignedEmail');

    // Perform magic email authentication.
    if(_firebaseAuth.isSignInWithEmailLink(link) && cachedEmail != null) {
      try {
        await _firebaseAuth.signInWithEmailLink(email: cachedEmail, emailLink: link);
      }
      on FirebaseAuthException catch(e) {
        throw AuthenticationException.fromCode(e.code);
      }
    }
    else {
      throw AuthenticationException('We could not process the link. Please try again or contact support.');
    }
  }

  /// Log out any currently authenticated account and update [stream] with an empty object.
  @override
  Future<void> logout() async  {
    await _firebaseAuth.signOut();
  }
}