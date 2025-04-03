import 'package:dartz/dartz.dart' hide Order;
import 'package:order_management/core/errors/exceptions.dart';
import '../entities/order.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<Order>>> getOrders();
  Future<Either<Failure, bool>> updateOrderStatus(
    String orderId,
    String newStatus,
  );
}
