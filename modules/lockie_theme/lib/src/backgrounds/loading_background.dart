import 'package:flutter/material.dart';

class LoadingBackground extends StatelessWidget {

  final bool loading;
  final Widget child;

  const LoadingBackground({ 
    Key? key, 
    required this.loading,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: child
        ),
        if(loading)
        Positioned.fill(
          child: Container(
            color: Colors.black54,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              )
            )
          )
        )
      ]
    );
  }
}