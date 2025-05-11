//A Package in flutter
import 'package:flutter/material.dart';
import 'package:tailor_app/features/orders/presentation/screens/order_screen.dart';

//Core Folders
import '../../../../core/models/local_models/style_model.dart';
import '../../../../core/models/sqlite_models/person_model.dart';
import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';

//Features Folders
import '../../../../features/profile/presentation/screens/profile_screen.dart';

import '../../../profile/presentation/providers/person_provider.dart';
import '../widgets/add_measurements.dart';

class DesignDetailScreen extends StatefulWidget {
  final StyleModel design;

  const DesignDetailScreen({Key? key, required this.design}) : super(key: key);

  @override
  _DesignDetailScreenState createState() => _DesignDetailScreenState();
}

class _DesignDetailScreenState extends State<DesignDetailScreen> {
  final PersonRepository _personRepository = PersonRepository();
  Future<PersonModel?>? _personFuture;

  @override
  void initState() {
    super.initState();
    _loadPersonData();
  }

  final int _currentIndex = 0;

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Navigator.pop(context);
        break;
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

  void _loadPersonData() {
    try {
      _personFuture = _personRepository.getFirstPerson();
    } catch (e) {
      // ignore: avoid_print
      print("Error initializing person future: $e");
      _personFuture = Future.error(e);
    }
  }

  void _navigateToProfileForEdit() {
    Navigator.pushReplacementNamed(context, AppRoutes.profileRoute).then((_) {
      if (mounted) {
        setState(() {
          _loadPersonData();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get theme data
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final chipTheme = Theme.of(context).chipTheme;

    final String title = widget.design.title;
    final String imageUrl = widget.design.imageUrl;
    final String description = widget.design.description;
    final String availableSizes = widget.design.sizes;
    final double baseNeed = widget.design.baseNeed;

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: SingleChildScrollView(
        padding: AppStyles.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: AppStyles.cardBorderRadius,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                height: 300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: AppStyles.headlineStyle,
            ),
            const SizedBox(height: 15),
            const Divider(),
            _buildSectionTitle('Description', textTheme),
            Text(
              description,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 15),
            const Divider(),
            _buildSectionTitle('Size', textTheme),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Available: $availableSizes',
                    style: TextStyle(color: Colors.grey[600])),
                _buildNeedChip(
                  '${baseNeed.toStringAsFixed(1)} m',
                  isBaseNeed: true,
                  chipTheme: chipTheme,
                  colorScheme: colorScheme,
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(),
            _buildSectionTitle('With Your Measurements:', textTheme),
            const SizedBox(height: 8),
            FutureBuilder<PersonModel?>(
              future: _personFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  final person = snapshot.data!;
                  final personalizedNeed = person.calculateFabricNeed(baseNeed);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('You will need:', style: textTheme.bodyText1),
                      _buildNeedChip(
                        '${personalizedNeed.toStringAsFixed(1)} m',
                        chipTheme: chipTheme,
                        colorScheme: colorScheme,
                      ),
                    ],
                  );
                } else {
                  // Use the extracted widget, pass the correct navigation method
                  return AddMeasurements(
                    onNavigateToProfile:
                        _navigateToProfileForEdit, // Use the specific edit navigation
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarDesign(
        selectedIndex: _currentIndex,
        onItemTapped: _navigateToScreen,
      ),
    );
  }

  // --- Keep your helper methods ---
  Widget _buildSectionTitle(String title, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: AppStyles.headlineStyle3),
    );
  }

  // Pass chipTheme for consistency
  Widget _buildNeedChip(
    String text, {
    bool isBaseNeed = false,
    required ChipThemeData chipTheme, // Receive chipTheme
    required ColorScheme colorScheme,
  }) {
    return Chip(
      label: Text(text),
      backgroundColor:
          isBaseNeed ? chipTheme.disabledColor : chipTheme.backgroundColor,
      padding: chipTheme.padding,
      shape: chipTheme.shape,
    );
  }
}
