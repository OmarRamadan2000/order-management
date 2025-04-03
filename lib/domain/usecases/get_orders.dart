import 'package:order_management/core/errors/exceptions.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:order_management/domain/entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrders {
  final OrderRepository repository;

  GetOrders(this.repository);

  Future<Either<Failure, List<Order>>> call() async {
    return await repository.getOrders();
  }
}
