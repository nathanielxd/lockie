import 'package:flutter/material.dart';

extension KeyGetPosition on GlobalKey<State> {

  RelativeRect getPosition([Offset offset = Offset.zero]) {
    final RenderBox button = currentContext!.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(currentContext!).overlay!.context.findRenderObject()! as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay), 
        button.localToGlobal(button.size.bottomRight(Offset.zero) + offset, ancestor: overlay)
      ),
      offset & overlay.size
    );

    return position;
  }
}