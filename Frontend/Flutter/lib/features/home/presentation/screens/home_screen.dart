//A Package in flutter
import 'package:flutter/material.dart';

//A Package in flutter need to install
import 'package:provider/provider.dart';

//Core Folders
import '../../../../core/models/local_models/style_model.dart';
import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';

//Features Folders
import '../../../home/data/style_data.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../orders/presentation/screens/order_screen.dart';
import '../../../orders/presentation/providers/order_provider.dart';

import '../../data/style_data.dart';
import '../widgets/design_card.dart';
import '../screens/design_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _currentIndex = 0;

  void _navigateToScreen(int index) {
    //If the currenIndex eqale the index will be go outside from the functions
    if (index == _currentIndex) return;

    switch (index) {
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OrdersScreen()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
    }
  }

  List<StyleModel> styles = StyleData.styles;
  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    try {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        context.read<OrderProvider>().fetchOrders();
      });
      print('get order');
    } catch (error) {
      // ignore: avoid_print
      print("Error loading orders: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStyles.nameApp, style: AppStyles.headlineStyle2),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppStyles.primaryColor),
        actions: [
          Consumer<OrderProvider>(builder: (context, order, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.list_alt_outlined),
                  onPressed: () => _navigateToScreen(1),
                ),
                if (order.uncompleteOrderCount > 0)
                  //To display above of the item
                  Positioned(
                    right: 6,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: AppStyles.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        "${order.uncompleteOrderCount}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          }),
          const SizedBox(width: 8),
        ],
      ),
      drawer: const AppDrawer(currentRoute: AppRoutes.homeRoute),
      body: SafeArea(
        child: GridView.builder(
          padding: AppStyles.defaultPadding,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: styles.length,
          itemBuilder: (context, index) {
            final design = styles[index];
            return DesignCard(
              imageUrl: design.imageUrl,
              title: design.title,
              availableSizes: design.sizes,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DesignDetailScreen(design: design),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarDesign(
        selectedIndex: _currentIndex,
        onItemTapped: _navigateToScreen,
      ),
    );
  }
}
