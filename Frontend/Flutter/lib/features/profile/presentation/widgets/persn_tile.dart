//A package in flutter
import 'package:flutter/material.dart';

//Core Folder
import '../../../../core/models/sqlite_models/person_model.dart';

class PersonTile extends StatelessWidget {
  const PersonTile({
    Key? key,
    required this.index,
    required this.person,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  final int index;
  final PersonModel person;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      tileColor: colorScheme.primary.withOpacity(0.05),
      leading: CircleAvatar(
        radius: 15,
        backgroundColor: colorScheme.primary.withOpacity(0.2),
        child: Text(
          '${index + 1}',
          style: textTheme.caption?.copyWith(color: colorScheme.primary),
        ),
      ),
      title: Text("Age: ${person.age}", style: textTheme.bodyText1),
      subtitle: Text("Height: ${person.height}cm, Weight: ${person.weight}kg",
          style: textTheme.bodyText2),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onEdit,
            icon: Icon(
              Icons.edit_outlined,
              color: colorScheme.primary,
              size: 20,
            ),
            tooltip: 'Edit',
          ),
          IconButton(
            onPressed: onDelete,
            icon: Icon(
              Icons.delete_outline_rounded,
              color: colorScheme.error,
              size: 20,
            ),
            tooltip: 'Delete',
          ),
        ],
      ),
      onTap: onEdit,
    );
  }
}
