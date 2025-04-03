import 'package:equatable/equatable.dart';
import '../../../domain/entities/order.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<Order> orders;

  const OrdersLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

class OrderUpdating extends OrdersState {
  final String orderId;

  const OrderUpdating(this.orderId);

  @override
  List<Object> get props => [orderId];
}

class OrderUpdated extends OrdersState {
  final String orderId;
  final String newStatus;
  const OrderUpdated(this.orderId, this.newStatus);

  @override
  List<Object> get props => [orderId, newStatus];
}

class OrdersError extends OrdersState {
  final String message;

  const OrdersError(this.message);

  @override
  List<Object> get props => [message];
}
