import 'package:flutter/material.dart';

class NavCustomPainter extends CustomPainter {
  /// The current animated position of the curve, normalized (0.0 to 1.0).
  final double currentPosition;

  /// The total number of items in the navigation bar.
  final int itemsLength;

  /// The color of the curved background.
  final Color color;

  /// The text direction of the current context.
  final TextDirection textDirection;

  /// The normalized span (width) of the curve.
  late double curveSpan;

  /// The normalized starting location of the curve.
  late double curveStartLoc;

  NavCustomPainter(
    this.currentPosition,
    this.itemsLength,
    this.color,
    this.textDirection,
  ) {
    // Calculate the normalized width of each item slot.
    final itemSpan = 1.0 / itemsLength;

    // Define the normalized width of the curve itself.
    // This value often needs fine-tuning to get the desired "carve" appearance.
    curveSpan = 0.2; // This is a common value, adjust if needed.

    // Calculate the normalized starting position of the curve.
    // It's centered within the current item's slot.
    curveStartLoc = currentPosition + (itemSpan - curveSpan) / 2;

    // Adjust for RTL text direction if necessary.
    // For LTR, the curve moves from left to right as index increases.
    // For RTL, it moves from right to left, so we invert the `curveStartLoc`.
    if (textDirection == TextDirection.rtl) {
      curveStartLoc = 1.0 - (curveStartLoc + curveSpan);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Start drawing the path.
    final path = Path()
      ..moveTo(0, 0); // Start at the top-left corner of the canvas.

    // Draw a line to the point just before the curve starts.
    // We add a small offset (0.1 * curveSpan) to make the curve start slightly earlier for a smoother transition.
    path.lineTo((curveStartLoc - 0.1 * curveSpan) * size.width, 0);

    // First cubic bezier curve: This creates the first half of the dip.
    // Control point 1: Pulls the curve down and towards the center.
    // Control point 2: Pulls the curve further down into the dip.
    // End point: The lowest point of the dip (center of the curve).
    path.cubicTo(
      (curveStartLoc + curveSpan * 0.20) * size.width, // C1.x (slightly into the curve)
      size.height * 0.05, // C1.y (starts to dip slightly)
      curveStartLoc * size.width, // C2.x (closer to the dip start)
      size.height * 0.60, // C2.y (deepest part of the curve)
      (curveStartLoc + curveSpan * 0.50) * size.width, // E.x (center of the curve)
      size.height * 0.60, // E.y (deepest part of the curve)
    );

    // Second cubic bezier curve: This creates the second half of the dip.
    // Control point 1: Continues from the deepest part, curving upwards.
    // Control point 2: Pulls the curve up and out of the dip.
    // End point: The point just after the curve ends.
    path.cubicTo(
      (curveStartLoc + curveSpan) * size.width, // C1.x (continues from curve end)
      size.height * 0.60, // C1.y (still at the deepest part, conceptually)
      (curveStartLoc + curveSpan - curveSpan * 0.20) * size.width, // C2.x (pulls up towards end)
      size.height * 0.05, // C2.y (finishes dipping and starts rising)
      (curveStartLoc + curveSpan + 0.1 * curveSpan) * size.width, // E.x (just after the curve)
      0, // E.y (back to the top edge)
    );

    // Draw a line to the top-right corner.
    path.lineTo(size.width, 0);

    // Draw lines to complete the rectangle for filling the bottom area.
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    // Close the path to form a complete shape.
    path.close();

    // Draw the path on the canvas with the specified paint.
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Only repaint if the position, items length, color, or text direction changes.
    // This makes the animation smooth without unnecessary repaints.
    return oldDelegate is NavCustomPainter &&
        (oldDelegate.currentPosition != currentPosition ||
            oldDelegate.itemsLength != itemsLength ||
            oldDelegate.color != color ||
            oldDelegate.textDirection != textDirection);
  }
}