import 'package:dartz/dartz.dart';
import 'package:order_management/core/errors/exceptions.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> loginUser(User user);
  Future<Either<Failure, bool>> isUserLoggedIn();
  Future<Either<Failure, void>> logoutUser();
}
