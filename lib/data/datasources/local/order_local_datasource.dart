import 'dart:convert';
import '../../../core/storage/shared_pref_manager.dart';
import '../../models/order_model.dart';

abstract class OrderLocalDataSource {
  Future<bool> cacheOrders(List<OrderModel> orders);
  List<OrderModel> getOrders();
  Future<bool> updateOrderStatus(String orderId, String newStatus);
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final SharedPrefManager sharedPrefManager;
  final String ordersKey = 'ORDERS_DATA';

  OrderLocalDataSourceImpl({required this.sharedPrefManager});

  @override
  Future<bool> cacheOrders(List<OrderModel> orders) async {
    List<Map<String, dynamic>> ordersList =
        orders.map((order) => order.toJson()).toList();
    return await sharedPrefManager.saveData(
      key: ordersKey,
      value: json.encode(ordersList),
    );
  }

  @override
  List<OrderModel> getOrders() {
    final jsonString = sharedPrefManager.getData(key: ordersKey);
    if (jsonString != null) {
      List<dynamic> ordersList = json.decode(jsonString);
      return ordersList.map((item) => OrderModel.fromJson(item)).toList();
    }
    return [];
  }

  @override
  Future<bool> updateOrderStatus(String orderId, String newStatus) async {
    List<OrderModel> orders = getOrders();
    int index = orders.indexWhere((order) => order.id == orderId);

    if (index != -1) {
      OrderModel oldOrder = orders[index];
      OrderModel updatedOrder = OrderModel(
        id: oldOrder.id,
        clientName: oldOrder.clientName,
        address: oldOrder.address,
        status: newStatus,
        details: oldOrder.details,
      );

      orders[index] = updatedOrder;
      return await cacheOrders(orders);
    }
    return false;
  }
}
