import 'package:dartz/dartz.dart';
import 'package:order_management/core/errors/exceptions.dart';
import '../repositories/order_repository.dart';

class UpdateOrderStatus {
  final OrderRepository repository;

  UpdateOrderStatus(this.repository);

  Future<Either<Failure, bool>> call(String orderId, String newStatus) async {
    return await repository.updateOrderStatus(orderId, newStatus);
  }
}
