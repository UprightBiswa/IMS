import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final double animatedPosition;
  final int totalItems;
  final int itemIndex;
  final ValueChanged<int> onTap;
  final IconData iconData; // Changed from Widget child to IconData
  final String label; // Added label
  final double barHeight;
  final bool isSelected; // Added isSelected to control text visibility/color

  NavButton({
    required this.onTap,
    required this.animatedPosition,
    required this.totalItems,
    required this.itemIndex,
    required this.iconData, // Use IconData directly
    required this.label, // Pass label
    required this.barHeight,
    required this.isSelected, // Pass selection state
  });

  @override
  Widget build(BuildContext context) {
    final desiredPosition = 1.0 / totalItems * itemIndex;
    final difference = (animatedPosition - desiredPosition).abs();
    // verticalAlignmentFactor will be 1 when directly under the floating button, 0 otherwise
    final verticalAlignmentFactor = 1 - totalItems * difference;

    // Opacity for the icon and text in the main bar.
    // When the floating button is over this item, its opacity should decrease.
    final double contentOpacity = difference < 1.0 / totalItems * 0.99 ? 0.1 : 1.0;
    // The previous opacity calculation was `totalItems * difference`.
    // We want it to be 1 when far, and decrease as it approaches the selected.
    // A simplified approach for fading out as selected item is near:
    final double fadeOutFactor = (difference * totalItems).clamp(0.0, 1.0); // 0 when directly under, 1 when far
    final double iconAndTextOpacity = isSelected ? 0.0 : fadeOutFactor; // If selected, hide icon/text in main bar

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onTap(itemIndex);
        },
        child: Container(
          height: barHeight,
          child: Column( // Use Column to stack icon and text
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                // This translation creates the "sinking" effect for unselected icons
                offset: Offset(0, isSelected ? 0 : verticalAlignmentFactor * (barHeight * 0.2)), // Adjust 0.2 as needed
                child: Opacity(
                  opacity: iconAndTextOpacity, // Apply calculated opacity
                  child: Icon(
                    iconData,
                    color: Colors.white, // Unselected icons are always white
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Opacity(
                opacity: iconAndTextOpacity, // Apply same opacity to label
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, // Label style as per normal nav bar
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}