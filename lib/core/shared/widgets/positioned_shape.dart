import 'package:flutter/material.dart';

class PositionedShape extends StatelessWidget {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double width;
  final double height;
  final Color color;
  final double angle;
  final BorderRadius? borderRadius;
  final BoxShape shape;

  const PositionedShape({
    super.key,
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.width,
    required this.height,
    required this.color,
    this.angle = 0.0,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Transform.rotate(
        angle: angle,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            shape: shape,
            borderRadius: shape == BoxShape.rectangle ? borderRadius : null,
          ),
          child: SizedBox(width: width, height: height),
        ),
      ),
    );
  }
}
