//A package in flutter
import 'package:flutter/material.dart';

//A package in flutter need to install
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//Core Folders
import '../../../../core/theme/app_styles.dart';
import '../../../../core/models/api_models/order_models.dart';
import '../../../../core/utils/messenger.dart'; // For snackbars
import '../../../../core/utils/navigations.dart';
import '../../../../core/utils/validations.dart';
import '../../../../core/widgets/custom_text_field.dart';

//Featuers Folders
import '../providers/order_provider.dart';

class ManageOrderDialog extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ManageOrderDialog({key, this.order});

  final OrderModel? order;

  @override
  State<ManageOrderDialog> createState() => _ManageOrderDialogState();
}

class _ManageOrderDialogState extends State<ManageOrderDialog> {
  // final _provider = OrderProvider();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _orderNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late bool _isDone;

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  late final bool _isEdit;
  OrderModel? order;
  @override
  void initState() {
    super.initState();
    List<OrderModel> orders = context.read<OrderProvider>().orders;
    if (widget.order != null) {
      final index = orders.indexWhere((order) => order.id == widget.order!.id);
      index != -1 ? order = orders[index] : order = widget.order;
    } else {
      order = widget.order;
    }
    _isEdit = order != null;

    _orderNameController = TextEditingController(text: order?.orderName ?? '');
    _descriptionController =
        TextEditingController(text: order?.description ?? '');
    _startDateController = TextEditingController(text: order?.startDate ?? '');
    _endDateController = TextEditingController(text: order?.endDate ?? '');

    _isDone = order?.done ?? false;
    if (_isEdit) {
      _selectedStartDate = _tryParseDate(order!.startDate);
      _selectedEndDate = _tryParseDate(order!.endDate);
    }
  }

  DateTime? _tryParseDate(String dateString) {
    try {
      return DateFormat('yyyy-MM-dd').parseStrict(dateString);
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    _orderNameController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    //Q1: Where is the done.dispse()...?
    //Q2: What means dispose()..?
    //A1: 'Done' propraty will take a defult value so we did not crate a controller for it.
    //A2: That for the memory and it's space.
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: (isStartDate ? _selectedStartDate : _selectedEndDate) ??
          DateTime.now(),

      //Why use DateTime(2000)
      //That means the user can choese jest from (2000 to 2090).
      firstDate: DateTime(2000),
      lastDate: DateTime(2090),
    );
    if (picked != null) {
      setState(() {
        final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        if (isStartDate) {
          _selectedStartDate = picked;
          _startDateController.text = formattedDate;
        } else {
          _selectedEndDate = picked;
          _endDateController.text = formattedDate;
        }
      });
    }
  }

  Future<void> _saveOrder() async {
    if (_formKey.currentState!.validate()) {
      final orderData = OrderModel(
        id: _isEdit ? widget.order!.id : null,
        orderName: _orderNameController.text.trim(),
        description: _descriptionController.text.trim(),
        startDate: _startDateController.text.trim(),
        endDate: _endDateController.text.trim(),
        done: _isDone,
      );

      try {
        OrderModel? result;
        if (_isEdit) {
          context.read<OrderProvider>().updateOrder(orderData);
          showSuccessSnackBar(
              context, '${orderData.orderName} updated successfully');
        } else {
          context.read<OrderProvider>().addOrder(orderData);
          showSuccessSnackBar(
              context, '${orderData.orderName} added successfully');
        }
        if (mounted) pop(context, result);
      } catch (error) {
        if (mounted) showErrorSnackBar(context, error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _isEdit ? 'Edit Order' : 'Add Order',
                  style: AppStyles.bodyTextStyle,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: _orderNameController,
                  label: 'Order Name',
                  validator: requiredValidator,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _descriptionController,
                  label: 'Description',
                ),
                const SizedBox(height: 16),
                //Start Data Piker
                TextFormField(
                  controller: _startDateController,
                  decoration: InputDecoration(
                    labelText: 'Start Date (YYYY-MM-DD)',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context, true),
                    ),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context, true),
                  validator: requiredValidator,
                ),
                const SizedBox(height: 16),
                // End Date Picker
                TextFormField(
                  controller: _endDateController,
                  decoration: InputDecoration(
                    labelText: 'End Date (YYYY-MM-DD)',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context, false),
                    ),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context, false),
                  validator: requiredValidator,
                ),
                const SizedBox(height: 24),
                // Save and Cancel Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () => pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppStyles.primaryColor,
                        onPrimary: Colors.white,
                      ),
                      onPressed: _saveOrder,
                      child: Text(_isEdit ? 'Update' : 'Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
