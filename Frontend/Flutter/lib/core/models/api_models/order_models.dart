import '../../constants/api_endpoints_order.dart';

class OrderModel {
  const OrderModel({
    this.id,
    required this.orderName,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.done = false,
  });

  final int? id;
  final String orderName;
  final String description;
  final String startDate;
  final String endDate;
  final bool done;

  factory OrderModel.fromMap(Map<String, dynamic> map) => OrderModel(
        id: map[ApiKeys.id],
        orderName: map[ApiKeys.orderName],
        description: map[ApiKeys.description],
        startDate: map[ApiKeys.startDate],
        endDate: map[ApiKeys.endDate],
        done: (map[ApiKeys.done] == 1),
      );

  Map<String, dynamic> toMap() => {
        ApiKeys.orderName: orderName,
        ApiKeys.description: description,
        ApiKeys.startDate: startDate,
        ApiKeys.endDate: endDate,
        ApiKeys.done: done ? 1 : 0,
      };
}
