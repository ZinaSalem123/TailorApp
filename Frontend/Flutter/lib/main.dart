//A package in flutter
import 'package:flutter/material.dart';

//A package in flutter need to install
import 'package:provider/provider.dart';

//Core Folders
import 'core/database/sqflite_database.dart';
import 'core/navigation/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_styles.dart';

//Featuers Folders
import 'features/home/presentation/screens/home_screen.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';
import 'features/profile/presentation/screens/profile_screen.dart';
import 'features/orders/presentation/providers/order_provider.dart';
import 'features/orders/presentation/screens/order_screen.dart';

void main() async {
  //Ensure bindings are initialized (critical for async before runApp)
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize the database (critical step that was missing)
  try {
    await SqfliteDatabase.initialize();
    // ignore: avoid_print
    print("Database initialization complete.");
  } catch (e) {
    // ignore: avoid_print
    print("FATAL ERROR: Database could not be initialized. $e");
  }
  //Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderProvider(),
      child: MaterialApp(
        title: AppStyles.nameApp,
        theme: buildAppTheme(context),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.onboardingRoute,
        routes: {
          AppRoutes.onboardingRoute: (context) => const OnboardingPage(),
          AppRoutes.homeRoute: (context) => const HomeScreen(),
          AppRoutes.profileRoute: (context) => const ProfileScreen(),
          AppRoutes.ordersRoute: (context) => const OrdersScreen(),
        },
      ),
    );
  }
}
