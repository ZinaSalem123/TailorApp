import 'package:flutter/material.dart';
import 'package:tailor_app/core/navigation/app_routes.dart';
import 'package:tailor_app/core/theme/app_styles.dart';
import 'package:tailor_app/features/about_us/about_us.dart';
import 'package:tailor_app/features/home/presentation/screens/home_screen.dart';
import 'package:tailor_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:tailor_app/features/orders/presentation/screens/order_screen.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({Key? key, required this.currentRoute}) : super(key: key);

  static const Color _highlightColor = AppStyles.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppStyles.primaryColor,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.png"),
              radius: 40,
            ),
            accountName: Text(
              "Your Name",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              'your.email@example.com',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.home,
            text: "Home Page",
            routeName: AppRoutes.homeRoute,
            onTap: () {
              if (currentRoute != AppRoutes.homeRoute) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              } else {
                Navigator.pop(context); // Just close the drawer
              }
            },
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.description,
            text: "Orders",
            routeName: AppRoutes.ordersRoute,
            onTap: () {
              if (currentRoute != AppRoutes.ordersRoute) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrdersScreen()));
              } else {
                Navigator.pop(context);
              }
            },
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.person,
            text: "Profile",
            routeName: AppRoutes.profileRoute,
            onTap: () {
              if (currentRoute != AppRoutes.profileRoute) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              } else {
                Navigator.pop(context);
              }
            },
          ),
          const Divider(),
          _buildDrawerItem(
            context: context,
            icon: Icons.info_outline,
            text: "About Us",
            routeName: AppRoutes.aboutUsRoute,
            onTap: () {
              if (currentRoute != AppRoutes.aboutUsRoute) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutUs()));
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String text,
    required String routeName,
    required VoidCallback onTap,
  }) {
    final bool isSelected = (currentRoute == routeName);
    final Color? itemColor = isSelected ? _highlightColor : null;

    return ListTile(
      leading: Icon(icon, color: itemColor),
      title: Text(
        text,
        style: TextStyle(color: itemColor),
      ),
      selected: isSelected,
      selectedTileColor: isSelected ? _highlightColor.withOpacity(0.1) : null,
      onTap: onTap,
    );
  }
}
