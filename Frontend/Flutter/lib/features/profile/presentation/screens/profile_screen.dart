//A package in flutter
import 'package:flutter/material.dart';

//Core Folders
import '../../../../core/models/sqlite_models/person_model.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/utils/messenger.dart';

//Features Folders
import '../../../../features/orders/presentation/screens/order_screen.dart';
import '../providers/person_provider.dart';
import '../widgets/manage_pserson_dialog.dart';
import '../widgets/person_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _repository = PersonRepository();

  final int _currentIndex = 2;

  void _navigateToScreen(int index) {
    if (index == _currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pop(context);
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OrdersScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const CustomAppBar(title: "Profile"),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "UserName",
              style: AppStyles.bodyTextStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "useremail@gmail.com",
              style: AppStyles.bodyTextStyle,
            ),
            Center(
              child: FutureBuilder<PersonModel?>(
                //Get the person data:
                future: _repository.getFirstPerson(),
                builder: (_, snapshot) {
                  //if the connection is loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                    //if some thing occurs prblem
                  } else if (snapshot.hasError) {
                    return Padding(
                        padding: AppStyles.defaultPadding,
                        child: Text('Error: ${snapshot.error}',
                            style: TextStyle(color: colorScheme.error)));

                    //if i get the data
                  } else if (snapshot.hasData && snapshot.data != null) {
                    final person = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PersonCard(
                        person: person,
                        onEdit: () => _showManageDialog(person: person),
                        onDelete: () => _confirmAndDelete(person),
                      ),
                    );
                  } else {
                    return _buildAddProfilePrompt();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarDesign(
        selectedIndex: _currentIndex,
        onItemTapped: _navigateToScreen,
      ),
    );
  }

  Future<void> _confirmAndDelete(PersonModel person) async {
    final colorScheme = Theme.of(context).colorScheme;
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text(
              'Are you sure you want to delete your measurements data?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: colorScheme.error)),
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(primary: colorScheme.error),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true && mounted) {
      // Check mounted after async gap
      try {
        await _repository.deletePerson(person.id!);
        setState(() {});
        showSuccessSnackBar(context, 'Measurements deleted successfully');
      } catch (e) {
        showErrorSnackBar(context, 'Failed to delete: $e');
      }
    }
  }

  Widget _buildAddProfilePrompt() {
    final textTheme = Theme.of(context).textTheme;
    // ignore: unused_local_variable
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: AppStyles.defaultPadding.copyWith(left: 30, right: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/4.png',
            height: 150,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          const Text(
            "Add Your Measurements",
            style: AppStyles.headlineStyle2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            "Adding your details helps in calculating the right amount of fabric needed.",
            style: textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          ElevatedButton.icon(
            onPressed: () => _showManageDialog(),
            icon: const Icon(Icons.add, size: 20),
            label: const Text('Add Details'),
          ),
        ],
      ),
    );
  }

  void _showManageDialog({PersonModel? person}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ManagePersonDialog(person: person),
    ).then((result) {
      if (result == true && mounted) {
        setState(() {});
        showSuccessSnackBar(
            context, person == null ? 'Details Added!' : 'Details Updated!');
      }
    });
  }
}
