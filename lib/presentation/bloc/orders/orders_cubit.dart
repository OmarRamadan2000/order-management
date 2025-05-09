import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_management/domain/entities/order.dart';
import '../../../domain/usecases/get_orders.dart';
import '../../../domain/usecases/update_order_status.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrders getOrders;
  final UpdateOrderStatus updateOrderStatus;
  List<Order> _orders = [];
  OrdersCubit({required this.getOrders, required this.updateOrderStatus})
      : super(OrdersInitial());

  Future<void> loadOrders() async {
    emit(OrdersLoading());
    final result = await getOrders();
    result.fold((failure) => emit(OrdersError(failure.toString())), (orders) {
      _orders = orders;
      emit(OrdersLoaded(_orders));
    });
  }

  Future<void> updateStatus(String orderId, String newStatus) async {
    emit(OrderUpdating(orderId));
    final result = await updateOrderStatus(orderId, newStatus);
    result.fold((failure) => emit(OrdersError(failure.toString())), (success) {
      if (success) {
        _orders = _orders.map((order) {
          if (order.id == orderId) {
            return order.copyWith(status: newStatus);
          }
          return order;
        }).toList();
        emit(OrdersLoaded(_orders));
        emit(OrderUpdated(orderId, newStatus));
      } else {
        emit(const OrdersError('Failed to update order status'));
      }
    });
  }

  void createOrder(Order order) {
    _orders = [order, ..._orders];
    log(_orders[0].clientName);
    emit(OrdersLoaded(_orders));
  }
}
