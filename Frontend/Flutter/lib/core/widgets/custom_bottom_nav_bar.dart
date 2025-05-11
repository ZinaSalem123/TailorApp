//A Package in flutter
import 'package:flutter/material.dart';

import '../../core/theme/app_styles.dart';
import 'bottom_nav_item.dart';

const IconData homeIcon = Icons.home;
const IconData homeIconOutline = Icons.home_outlined;
const IconData ordersIcon = Icons.list_alt;
const IconData ordersIconOutline = Icons.list_alt_outlined;
const IconData profileIcon = Icons.person;
const IconData profileIconOutline = Icons.person_outlined;

class CustomBottomNavBarDesign extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBarDesign({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = AppStyles.primaryColor;
    final Color unselectedColor = Colors.grey.shade600;

    return BottomAppBar(
      color: Colors.white,
      elevation: 8.0,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            BottomNavItemDesign(
              iconData: homeIconOutline,
              selectedIconData: homeIcon,
              label: 'Home',
              isSelected: selectedIndex == 0,
              onTap: () => onItemTapped(0),
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
            ),
            BottomNavItemDesign(
              iconData: ordersIconOutline,
              selectedIconData: ordersIcon,
              label: 'Orders',
              isSelected: selectedIndex == 1,
              onTap: () => onItemTapped(1),
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
            ),
            BottomNavItemDesign(
              iconData: profileIconOutline,
              selectedIconData: profileIcon,
              label: 'Profile',
              isSelected: selectedIndex == 2,
              onTap: () => onItemTapped(2),
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
            ),
            // Add more items if needed
          ],
        ),
      ),
    );
  }
}
