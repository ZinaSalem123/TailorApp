//A package in flutter
import 'package:flutter/material.dart';

//A package in flutter need to install
import 'package:provider/provider.dart';

//Core Folders
import '../../../../core/models/api_models/order_models.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/utils/messenger.dart';

//Features Folders
import '../../../../features/profile/presentation/screens/profile_screen.dart';
import '../providers/order_provider.dart';
import '../widgets/manage_order_dialog.dart';
import '../widgets/order_tile.dart';

class OrdersScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const OrdersScreen({key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<OrderProvider>().fetchOrders();
    });
  }

  final int _currentIndex = 1;
  void _navigateToScreen(int index) {
    if (index == _currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pop(context);
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Order",
        actions: [
          IconButton(
            onPressed: () => _showAddOrderDialog(),
            icon: const Icon(Icons.add_circle_rounded),
          )
        ],
      ),
      body: Consumer<OrderProvider>(builder: (context, orders, child) {
        return Center(
          child: orders.isLoading
              ? const CircularProgressIndicator()
              : orders.error != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '😓',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 50),
                        ),
                        const SizedBox(height: 8),
                        Text('${orders.error}!!!!',
                            textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: orders.fetchOrders,
                          child: const Text('Retry again'),
                        ),
                      ],
                    )
                  // ignore: prefer_is_not_empty
                  : !orders.orders.isEmpty
                      ? ListView.separated(
                          itemBuilder: (_, i) {
                            final order = orders.orders[i];
                            return OrderTile(
                              key: ValueKey(order.id),
                              index: i,
                              order: order,
                              onDeleteSuccess: (order) async {
                                context
                                    .read<OrderProvider>()
                                    .deleteOrder(order.id!);
                              },
                            );
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 5),
                          itemCount: orders.orders.length,
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.note_alt_outlined,
                              size: 100,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 24),
                            const Text('There is no order items yet'),
                            const SizedBox(height: 16),
                            TextButton.icon(
                              onPressed: () => _showAddOrderDialog(),
                              label: const Text('Add first order'),
                              icon: const Icon(Icons.add_circle_rounded),
                            ),
                          ],
                        ),
        );
      }),
      bottomNavigationBar: CustomBottomNavBarDesign(
        selectedIndex: _currentIndex,
        onItemTapped: _navigateToScreen,
      ),
    );
  }

  void _showAddOrderDialog() {
    showDialog<OrderModel?>(
      context: context,
      builder: (_) => const ManageOrderDialog(),
    ).then((newOrder) {
      if (newOrder != null) {
        try {
          // context.read<OrderProvider>().add(newOrder);
        } catch (error) {
          showErrorSnackBar(context, error.toString());
        }
      }
    });
  }
}
