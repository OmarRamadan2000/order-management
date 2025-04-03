import 'package:dartz/dartz.dart' hide Order;
import 'package:dio/dio.dart';
import 'package:order_management/core/errors/exceptions.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/local/order_local_datasource.dart';
import '../datasources/remote/order_remote_datasource.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final OrderLocalDataSource localDataSource;

  OrderRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Order>>> getOrders() async {
    try {
      // Try to get orders from the API
      final remoteOrders = await remoteDataSource.getOrders();
      // Cache the orders locally
      await localDataSource.cacheOrders(remoteOrders);
      return Right(remoteOrders);
    } catch (e) {
      try {
        // If API fails, fallback to local cache
        final localOrders = localDataSource.getOrders();
        return Right(localOrders);
      } catch (e) {
        if (e is DioException) {
          return Left(ServerFailure.fromDiorError(e));
        }
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> updateOrderStatus(
    String orderId,
    String newStatus,
  ) async {
    try {
      final success = await remoteDataSource.updateOrderStatus(
        orderId,
        newStatus,
      );
      if (success) {
        await localDataSource.updateOrderStatus(orderId, newStatus);
        return const Right(true);
      }
      return Left(ServerFailure('Failed to update order status'));
    } catch (e) {
      try {
        final result = await localDataSource.updateOrderStatus(
          orderId,
          newStatus,
        );
        return Right(result);
      } catch (e) {
        if (e is DioException) {
          return Left(ServerFailure.fromDiorError(e));
        }
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
