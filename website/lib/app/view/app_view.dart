import 'package:flutter/material.dart';
import 'package:lockie_theme/lockie_theme.dart';
import 'package:lockie_website/landing/landing.dart';

class AppView extends StatelessWidget {

  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lockie.',
      theme: LockieThemes.website,
      routes: {
        '/': (context) => LandingPage(),
      },
    );
  }
}