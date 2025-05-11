//Core Folders
import '../../../../core/models/api_models/order_models.dart';
import '../../../../core/constants/api_endpoints_order.dart';
import '../../../../core/services/api_service.dart';

class OrderServices {
  const OrderServices._();

  static const OrderServices instance = OrderServices._();

  final _api = ApiService.instance;

  //http://127.0.0.1:8000/api/orders/index
  Future<List<OrderModel>> getOrders() async {
    final response = await _api.get(ApiEndpointsOrders.ordersIndex);
    if (response.success && response.body is List) {
      return (response.body as List)
          .map((orderJson) =>
              OrderModel.fromMap(orderJson as Map<String, dynamic>))
          .toList();
    } else if (!response.success) {
      throw response.message;
    } else {
      throw 'Invalid response format: Expected a List of orders.';
    }
  }

  //http://127.0.0.1:8000/api/orders/store
  Future<OrderModel> addOrder(OrderModel order) async {
    final response =
        await _api.post(ApiEndpointsOrders.ordersStore, body: order.toMap());
    if (response.success) return OrderModel.fromMap(response.body);

    throw response.message;
  }

  Future<OrderModel> updateOrder(OrderModel order) async {
    final response = await _api.put(
      '${ApiEndpointsOrders.ordersUpdate}/${order.id}',
      body: order.toMap(),
    );

    if (response.success) return OrderModel.fromMap(response.body);

    throw response.message;
  }

  //http://127.0.0.1:8000/api/orders/isComplete/4
  Future<void> changeStatus(int id, bool done) async {
    final response = await _api.patch(
      '${ApiEndpointsOrders.ordersIsComplete}/$id',
      body: {ApiKeys.done: done},
    );

    if (!response.success) throw response.message;
  }

  //http://127.0.0.1:8000/api/orders/delete/4
  Future<void> deleteOrder(int id) async {
    final response =
        await _api.delete('${ApiEndpointsOrders.ordersDelete}/$id');

    if (!response.success) throw response.message;
  }
}
