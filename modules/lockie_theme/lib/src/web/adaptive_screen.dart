import 'package:flutter/material.dart';

class AdaptiveScreen extends StatelessWidget {

  final Widget mobileScreen;
  final Widget wideScreen;

  const AdaptiveScreen({ 
    Key? key,
    required this.mobileScreen,
    required this.wideScreen
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(size.width > size.height * 0.9) {
      return wideScreen;
    }
    else {
      return mobileScreen;
    }
  }
}