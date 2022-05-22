import 'package:flutter/material.dart';

extension KeyGetPosition on GlobalKey<State> {

  RelativeRect getRelativeRect() {
    final RenderBox widget = currentContext!.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(currentContext!).overlay!.context.findRenderObject()! as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        widget.localToGlobal(Offset.zero, ancestor: overlay), 
        widget.localToGlobal(widget.size.bottomRight(Offset.zero), ancestor: overlay)
      ),
      Offset.zero & overlay.size
    );

    return position;
  }

  Rect getRect() {
    final widget = currentContext!.findRenderObject() as RenderBox;
    final size = widget.size;
    final position = widget.localToGlobal(Offset.zero);

    return Rect.fromLTWH(position.dx, position.dy, size.width, size.height);
  }

  Offset getPosition() {
    final widget = currentContext!.findRenderObject() as RenderBox;
    final overlay = Navigator.of(currentContext!).overlay!.context.findRenderObject()! as RenderBox;

    return widget.localToGlobal(Offset.zero, ancestor: overlay);
  }
}