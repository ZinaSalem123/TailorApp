//A package in flutter
import 'package:flutter/material.dart';

//Core Folders
import '../../../../core/theme/app_styles.dart';
import '../../../../core/models/sqlite_models/person_model.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({
    Key? key,
    required this.person,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  final PersonModel person;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: AppStyles.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Your Details",
                style: textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold, color: colorScheme.primary)),
            const SizedBox(height: 10),
            _buildDetailRow(context, Icons.calendar_today_outlined, "Age",
                "${person.age} years"),
            _buildDetailRow(context, Icons.height_outlined, "Height",
                "${person.height} cm"),
            _buildDetailRow(context, Icons.monitor_weight_outlined, "Weight",
                "${person.weight} kg"),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text("Edit"),
                  onPressed: onEdit,
                ),
                const SizedBox(width: 20),
                TextButton.icon(
                  icon: Icon(Icons.delete_outline, color: colorScheme.error),
                  label: Text("Delete",
                      style: TextStyle(color: colorScheme.error)),
                  onPressed: onDelete,
                  style: TextButton.styleFrom(primary: colorScheme.error),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      BuildContext context, IconData icon, String label, String value) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.primary.withOpacity(0.7), size: 20),
          const SizedBox(width: 12),
          Text("$label: ",
              style:
                  textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
