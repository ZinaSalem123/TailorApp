abstract class ApiEndpointsOrders {
  static const String orders = 'orders';

  //http://127.0.0.1:8000/api/orders/store
  static const String ordersStore = '$orders/store';
  //
  //http://127.0.0.1:8000/api/orders/index
  static const String ordersIndex = '$orders/index';

  //http://127.0.0.1:8000/api/orders/update/1
  static const String ordersUpdate = '$orders/update';

  //http://127.0.0.1:8000/api/orders/delete/1
  static const String ordersDelete = '$orders/delete';

  //http://127.0.0.1:8000/api/orders/isComplete/1
  static const String ordersIsComplete = '$orders/isComplete';
}

class ApiKeys {
  static const String id = 'id';
  static const String orderName = 'order_name';
  static const String description = 'description';
  static const String startDate = 'start_date';
  static const String endDate = 'end_date';
  static const String done = 'done';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String orders = 'orders';
}
