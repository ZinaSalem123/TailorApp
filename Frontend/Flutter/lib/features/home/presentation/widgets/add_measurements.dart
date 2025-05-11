//A Package in flutter
import 'package:flutter/material.dart';

class AddMeasurements extends StatelessWidget {
  final VoidCallback onNavigateToProfile;

  const AddMeasurements({
    Key? key,
    required this.onNavigateToProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: colorScheme.error,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.error.withOpacity(0.6))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "You need to add your measurements!",
            style: textTheme.headline6?.copyWith(
                color: colorScheme.onError, // Ensure contrast
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "Go to your profile to add details for accurate fabric estimation.",
            style: textTheme.bodyText2
                ?.copyWith(color: colorScheme.onError.withOpacity(0.9)),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            icon: Icon(Icons.person_add_alt_1,
                size: 18, color: colorScheme.error),
            label: const Text("Go to Profile -> ",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: onNavigateToProfile,
            style: TextButton.styleFrom(
              primary: Colors.grey,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          )
        ],
      ),
    );
  }
}
