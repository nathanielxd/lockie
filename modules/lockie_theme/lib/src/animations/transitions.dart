import 'package:flutter/material.dart';

class LockieTransitions {
  /// Fades and slides the widgets horizontally.
  static Widget slide(child, Animation animation) {
    final anim = animation.drive(
      Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.ease))
    );

    final anim2 = animation.drive(
      Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.easeIn))
    );

    return AnimatedBuilder(
      animation: anim,
      builder: (_, __) {
        return Opacity(
          opacity: anim2.value,
          child: Transform.translate(
            offset: Offset((anim.value * 100) - 100, 0),
            child: child,
          )
        );
      }
    );
  }

  static Widget navigate(child, Animation animation) {
    final tween = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.ease));
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