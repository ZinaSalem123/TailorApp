//A package in flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Core Folders
import '../../../../core/theme/app_styles.dart';
import '../../../../core/models/sqlite_models/person_model.dart';
import '../../../../core/utils/messenger.dart';
import '../../../../core/utils/navigations.dart';
import '../../../../core/utils/validations.dart';
import '../../../../core/widgets/custom_text_field.dart';

//Features Folder
import '../providers/person_provider.dart';

class ManagePersonDialog extends StatefulWidget {
  const ManagePersonDialog({Key? key, this.person}) : super(key: key);
  final PersonModel? person;

  @override
  State<ManagePersonDialog> createState() => _ManagePersonDialogState();
}

class _ManagePersonDialogState extends State<ManagePersonDialog> {
  late final TextEditingController _ageController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  final _repository = PersonRepository();
  final _formKey = GlobalKey<FormState>();
  late bool _isEdit;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final person = widget.person;
    _isEdit = person != null;
    _ageController = TextEditingController(text: person?.age.toString() ?? '');
    _heightController =
        TextEditingController(text: person?.height.toString() ?? '');
    _weightController =
        TextEditingController(text: person?.weight.toString() ?? '');
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _savePerson() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    final int age = int.tryParse(_ageController.text) ?? 0;
    final int height = int.tryParse(_heightController.text) ?? 0;
    final int weight = int.tryParse(_weightController.text) ?? 0;

    if (age <= 0 || height <= 0 || weight <= 0) {
      if (mounted) {
        showErrorSnackBar(context, 'Please enter valid positive numbers.');
      }
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    final person = PersonModel(
      id: widget.person?.id,
      age: age,
      height: height,
      weight: weight,
    );

    try {
      if (_isEdit) {
        await _repository.updatePerson(person);
      } else {
        await _repository.addPerson(person);
      }
      if (mounted) pop(context, true);
    } catch (e) {
      if (mounted) showErrorSnackBar(context, 'Failed to save details: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.borderRadiusValue)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _isEdit ? 'Edit Details' : 'Add Your Details',
                style: textTheme.headline6, // Use theme style
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: _ageController,
                label: 'Age (years)',
                validator: requiredValidator,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _heightController,
                label: 'Height (cm)',
                validator: requiredValidator,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _weightController,
                label: 'Weight (kg)',
                validator: requiredValidator,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: _isLoading ? null : () => pop(context, false),
                    child: const Text('Cancel'),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.grey.shade700, // Text color
                      side: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _savePerson,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ))
                        : const Text('Save'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
