import 'package:flutter/material.dart';

class AnimatedCircularProgressIndicator extends StatefulWidget {
  final double? value;
  final Color? backgroundColor;
  final Color? valueColor;
  final double strokeWidth;

  const AnimatedCircularProgressIndicator({
    Key? key,
    this.value,
    this.backgroundColor,
    this.valueColor,
    this.strokeWidth = 4.0,
  }) : super(key: key);

  @override
  _AnimatedCircularProgressIndicatorState createState() =>
      _AnimatedCircularProgressIndicatorState();
}

class _AnimatedCircularProgressIndicatorState
    extends State<AnimatedCircularProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: widget.value ?? controller.value,
      backgroundColor: widget.backgroundColor ?? Colors.grey.shade200,
      valueColor: widget.valueColor != null
          ? AlwaysStoppedAnimation<Color>(widget.valueColor!)
          : controller.drive(ColorTween(
              begin: Colors.blue,
              end: Colors.red,
            )),
      strokeWidth: widget.strokeWidth,
    );
  }
}
