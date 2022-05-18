import 'package:flutter/material.dart';

class LoopTransition extends StatefulWidget {

  final Widget Function(Animation<double> animation, Widget? widget) builder;
  final Widget? child;
  /// Duration of one animation cycle, defaults to 1 second.
  final Duration? duration;

  const LoopTransition({
    Key? key, 
    required this.builder,
    this.child,
    this.duration,
  }) : super(key: key);

  @override
  State<LoopTransition> createState() => _LoopTransitionState();
}

class _LoopTransitionState extends State<LoopTransition> with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? Duration(seconds: 1)
    );

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller, 
      builder: (context, child) => widget.builder(controller, child),
      child: widget.child,
    );
  }
}