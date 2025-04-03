import 'package:order_management/core/errors/exceptions.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUser {
  final AuthRepository repository;
  LoginUser(this.repository);
  Future<Either<Failure, bool>> call(User user) async {
    return await repository.loginUser(user);
  }
}
