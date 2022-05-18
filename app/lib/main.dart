import 'package:dynamic_assets/dynamic_assets.dart';
import 'package:flutter/material.dart';
import 'package:lockie_app/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DynamicAssets.load();
  final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  print(initialLink?.link.toString());
  runApp(App(authenticationLink: initialLink?.link.toString()));
}