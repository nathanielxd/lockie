import 'package:fast_strings/fast_strings.dart';
import 'package:flutter/material.dart';
import 'package:lockie_website/app/app.dart';
import 'package:lockie_website/configure_web.dart';

void main() async {
  configureApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Strings.initialize('assets/copy.yaml');
  runApp(App());
}