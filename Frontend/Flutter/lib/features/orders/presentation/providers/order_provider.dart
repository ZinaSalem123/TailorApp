//A package in flutter need to install
import 'package:flutter/cupertino.dart';

//Core Folders
import '../../../../core/models/api_models/order_models.dart';
import '../../../../core/constants/api_endpoints_order.dart';
import '../../../../core/services/api_service.dart';

class OrderProvider with ChangeNotifier {
  final _api = ApiService.instance;

  List<OrderModel> _orders = [];
  bool _isLoading = false;

  // bool _isCompleted = false;
  bool _isChangeStatusLoading = false;
  bool _isDeleteLoading = false;
  Object? _error;

  int get uncompleteOrderCount => _orders.where((order) => !order.done).length;
  List<OrderModel> get orders => _orders;
  // bool get isCompleted => _isCompleted;
  bool get isChangeStatusLoading => _isChangeStatusLoading;
  bool get isDeleteLoading => _isDeleteLoading;
  bool get isLoading => _isLoading;
  Object? get error => _error;

  //http://127.0.0.1:8000/api/orders/index
  Future<void> fetchOrders() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _api.get(ApiEndpointsOrders.ordersIndex);

      if (response.success && response.body is List) {
        _orders = (response.body as List)
            .map((orderJson) =>
                OrderModel.fromMap(orderJson as Map<String, dynamic>))
            .toList();
      } else {
        _error = response.message;
        notifyListeners();
        throw response.message;
      }
    } catch (e) {
      _error = e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //http://127.0.0.1:8000/api/orders/store
  Future<OrderModel> addOrder(OrderModel order) async {
    try {
      _orders.add(order);
      _isLoading = true;
      notifyListeners();

      final response = await _api.post(
        ApiEndpointsOrders.ordersStore,
        body: order.toMap(),
      );

      //
      fetchOrders();
    } catch (e) {
      _error = e;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return order;
  }

  Future<OrderModel> updateOrder(OrderModel order) async {
    try {
      final index = _orders.indexWhere((order) => order.id == order.id);
      if (index != -1) {
        _orders[index] = order;
        _isLoading = true;
        notifyListeners();
      }
      final response = await _api.put(
        '${ApiEndpointsOrders.ordersUpdate}/${order.id}',
        body: order.toMap(),
      );
      fetchOrders();
    } catch (e) {
      _error = e;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return order;
  }

  //http://127.0.0.1:8000/api/orders/isComplete/4
  Future<void> changeStatus(int id, bool done) async {
    try {
      final index = _orders.indexWhere((order) => order.id == id);
      if (index != -1) {
        final order = _orders[index];
        final updatedOrder = OrderModel(
          id: order.id,
          orderName: order.orderName,
          description: order.description,
          startDate: order.startDate,
          endDate: order.endDate,
          done: done,
        );
        _orders[index] = updatedOrder;

        _isChangeStatusLoading = true;

        notifyListeners();
        final response = await _api.patch(
          '${ApiEndpointsOrders.ordersIsComplete}/$id',
          body: {ApiKeys.done: done},
        );
      }
    } catch (e) {
      _error = e;
      notifyListeners();
    } finally {
      _isChangeStatusLoading = false;
      notifyListeners();
    }
  }

  //http://127.0.0.1:8000/api/orders/delete/4
  Future<void> deleteOrder(int id) async {
    try {
      final index = _orders.indexWhere((order) => order.id == id);
      _orders.removeAt(index);
      _isDeleteLoading = true;
      notifyListeners();
      final response =
          await _api.delete('${ApiEndpointsOrders.ordersDelete}/$id');
      fetchOrders();
    } catch (e) {
      _error = e;
      notifyListeners();
    } finally {
      _isDeleteLoading = false;
      notifyListeners();
    }
  }
}
