import 'package:flutter/material.dart';

class BottomNavItemDesign extends StatelessWidget {
  final IconData iconData;
  final IconData selectedIconData;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final double indicatorHeight;
  final double indicatorWidth;

  const BottomNavItemDesign({
    Key? key,
    required this.iconData,
    required this.selectedIconData,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
    this.indicatorHeight = 3.0,
    this.indicatorWidth = 35.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected ? selectedColor : unselectedColor;
    final IconData currentIcon = isSelected ? selectedIconData : iconData;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(currentIcon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Container(
                height: indicatorHeight,
                width: indicatorWidth,
                color: isSelected ? selectedColor : Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
