import 'package:flutter/material.dart';

class AttendanceTrendAnalyticsGraph extends StatelessWidget {
  const AttendanceTrendAnalyticsGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: const Color(0xFF5F5D5D).withValues(alpha: .10),
          width: 1.7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Attendance Trend Analytics',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 16 / 9, // Adjust aspect ratio as needed
            child: CustomPaint(painter: _AttendanceLinePainter()),
          ),
        ],
      ),
    );
  }
}

class _AttendanceLinePainter extends CustomPainter {
  // Define data points (month, value) to match the image
  // These values are estimated from the image.
  final List<double> yValues = [
    95,
    65,
    40,
    58,
    65,
  ]; // Corresponding to Jan, Feb, Mar, Apr, May
  final List<String> xLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];
  final List<double> yAxisLabels = [0, 9, 17, 26, 34, 43, 51, 60, 68, 77, 100];

  @override
  void paint(Canvas canvas, Size size) {
    final double padding = 30.0; // Padding for axes and labels
    final double graphWidth = size.width - 2 * padding;
    final double graphHeight = size.height - 2 * padding;

    final Paint linePaint = Paint()
      ..color =
          const Color(0xFF42A5F5) // Blue color for the line
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final Paint dotPaint = Paint()
      ..color =
          const Color(0xFF42A5F5) // Blue for dots
      ..style = PaintingStyle.fill;

    final Paint gridPaint = Paint()
      ..color =
          Colors.grey[300]! // Light grey for grid lines
      ..strokeWidth = 0.8;

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    // Calculate scaling factors
    final double maxXValue = xLabels.length - 1; // 0-indexed
    final double maxYValue = yAxisLabels.last; // Max value on Y-axis (100)

    // Draw Y-axis labels and horizontal grid lines
    for (int i = 0; i < yAxisLabels.length; i++) {
      final double yValue = yAxisLabels[i];
      final double yPos = padding + graphHeight * (1 - (yValue / maxYValue));

      // Draw label
      textPainter.text = TextSpan(
        text: yValue.toInt().toString(),
        style: const TextStyle(color: Colors.black54, fontSize: 10),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(padding - textPainter.width - 8, yPos - textPainter.height / 2),
      );

      // Draw horizontal grid line
      if (yValue != 0 && yValue != 100) {
        // Don't draw for 0 and 100 if they are edges
        canvas.drawLine(
          Offset(padding, yPos),
          Offset(size.width - padding, yPos),
          gridPaint,
        );
      }
    }

    // Draw X-axis labels and vertical grid lines
    for (int i = 0; i < xLabels.length; i++) {
      final String label = xLabels[i];
      final double xPos = padding + (i / maxXValue) * graphWidth;

      // Draw label
      textPainter.text = TextSpan(
        text: label,
        style: const TextStyle(color: Colors.black54, fontSize: 10),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(xPos - textPainter.width / 2, size.height - padding + 8),
      );

      // Draw vertical grid line
      if (i > 0 && i < xLabels.length - 1) {
        // Don't draw for first and last, or adjust as needed
        canvas.drawLine(
          Offset(xPos, padding),
          Offset(xPos, size.height - padding),
          gridPaint,
        );
      }
    }

    // Draw the line graph
    final Path path = Path();
    for (int i = 0; i < yValues.length; i++) {
      final double xPos = padding + (i / maxXValue) * graphWidth;
      final double yPos =
          padding + graphHeight * (1 - (yValues[i] / maxYValue));

      if (i == 0) {
        path.moveTo(xPos, yPos);
      } else {
        path.lineTo(xPos, yPos);
      }
      canvas.drawCircle(Offset(xPos, yPos), 3.0, dotPaint); // Draw dots
    }
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Only repaint if data changes, which is not handled in this static example
  }
}
