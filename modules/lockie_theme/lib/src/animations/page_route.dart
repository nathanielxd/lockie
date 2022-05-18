import 'package:flutter/material.dart';

class LockiePageRoute<T> extends MaterialPageRoute<T> {
  
  LockiePageRoute({ 
    required WidgetBuilder builder, 
    RouteSettings? settings
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context, 
    Animation<double> animation, 
    Animation<double> secondaryAnimation, 
    Widget child
  ) {
    final tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.ease));
    final anim = animation.drive(tween);
    
    return AnimatedBuilder(
      animation: anim,
      builder: (_, __) {
        return Opacity(
          opacity: anim.value,
          child: Transform.translate(
            offset: Offset(50 - anim.value * 50, 0),
            child: child,
          )
        );
      }
    );
  }
}