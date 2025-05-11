//A package in flutter
import 'package:flutter/material.dart';

//A package in flutter need to install
import 'package:provider/provider.dart';

//Core Folders
import '../../../../core/theme/app_styles.dart';
import '../../../../core/models/api_models/order_models.dart';
import '../../../../core/utils/messenger.dart';

//Featuers Folders
import '../providers/order_provider.dart' show OrderProvider;
import 'manage_order_dialog.dart';

class OrderTile extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const OrderTile({
    key,
    required this.index,
    required this.order,
    required this.onDeleteSuccess,
  });

  final int index;
  final OrderModel order;
  final Function(OrderModel) onDeleteSuccess;

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  // final _provider = OrderProvider();

  late OrderModel _order;

  bool _isDeleteLoading = false;

  bool _isChangeStatusLoading = false;

  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _order = widget.order;
    _isCompleted = _order.done;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.purple.withOpacity(.05),
      title: Text(
        widget.order.orderName,
        style: _isCompleted
            ? const TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.grey,
              )
            : const TextStyle(
                color: AppStyles.primaryColor, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.order.description,
            style: !_isCompleted ? TextStyle(color: Colors.grey[900]) : null,
          ),
          const SizedBox(height: 4),
          Text('Start Date: ${widget.order.startDate}',
              style: !_isCompleted ? TextStyle(color: Colors.grey[900]) : null),
          Text('End Date:   ${widget.order.endDate}',
              style: !_isCompleted ? TextStyle(color: Colors.grey[900]) : null),
        ],
      ),
      trailing: Consumer<OrderProvider>(builder: (context, order, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isDeleteLoading)
              _loadingWidget(Colors.red)
            else
              IconButton(
                onPressed: () async {
                  try {
                    context.read<OrderProvider>().deleteOrder(_order.id!);

                    // _isDeleteLoading = context.read<OrderProvider>().isDelele;
                    showSuccessSnackBar(
                      context,
                      '${_order.orderName} deleted successfully',
                    );
                  } catch (error) {
                    // _isDeleteLoading = context.read<OrderProvider>().isDelele;

                    showErrorSnackBar(context, error.toString());
                  }
                  // finally {
                  //   // _isDeleteLoading = context.read<OrderProvider>().isDelele;
                  // }
                },
                icon:
                    const Icon(Icons.delete_outline_rounded, color: Colors.red),
              ),
            IconButton(
              onPressed: () {
                showDialog<OrderModel?>(
                  context: context,
                  builder: (_) => ManageOrderDialog(order: _order),
                ).then((updatedOrder) {
                  if (updatedOrder != null) {
                    setState(() {
                      _order = updatedOrder;
                      _isCompleted = updatedOrder.done;
                    });
                    showSuccessSnackBar(
                      context,
                      '${updatedOrder.orderName} updated successfully',
                    );
                  }
                });
              },
              icon: const Icon(
                Icons.mode_edit_outline_rounded,
                color: Colors.blue,
              ),
            ),
            if (_isChangeStatusLoading)
              _loadingWidget(Colors.deepPurple)
            else
              Checkbox(
                value: _isCompleted,
                onChanged: (completed) async {
                  // _isChangeStatusLoading =
                  //     context.read<OrderProvider>().isChangeLoading;
                  try {
                    context
                        .read<OrderProvider>()
                        .changeStatus(_order.id!, completed!);
                    _isCompleted = completed;
                    showSuccessSnackBar(
                      context,
                      completed
                          ? '${_order.orderName} is completed'
                          : '${_order.orderName} is incomplete',
                    );
                  } catch (error) {
                    showErrorSnackBar(context, error.toString());
                  }
                  // finally {
                  //   setState(() {
                  //     _isChangeStatusLoading = false;
                  //   });
                  // }
                },
              ),
          ],
        );
      }),
    );
  }

  Widget _loadingWidget(Color color) => SizedBox(
        width: 48,
        child: Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(color: color, strokeWidth: 2),
          ),
        ),
      );
}
