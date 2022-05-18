import 'package:flutter/material.dart';
import 'package:lockie_app/menu/menu.dart';
import 'package:lockie_theme/lockie_theme.dart';

class MenuPage extends StatelessWidget {

  const MenuPage({Key? key}) : super(key: key);

  static PageRoute get route => LockiePageRoute(builder: (_) => MenuPage());

  @override
  Widget build(BuildContext context) {
		return MenuView();
  }
}
  