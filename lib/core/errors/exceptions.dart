import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDiorError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with api server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure('badCertificate with api server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response!.statusCode!,
          e.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure('Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 401 && response["errors"] != null) {
      if (response["errors"] != 401) {
        if (response["errors"]["email"] != null) {
          return ServerFailure(response["errors"]["email"][0]);
        } else if (response["errors"]["phone"] != null) {
          return ServerFailure(response["errors"]["phone"][0]);
        }
      } else {
        return ServerFailure(response["msg"]);
      }
    }

    if (statusCode == 404 ||
        statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 422) {
      return ServerFailure(response["msg"]);
    } else if (statusCode == 500) {
      return ServerFailure("هناك مشكلة في الخادم يرجى المحاولة لاحقا");
    } else {
      return ServerFailure("لقد حدث خطأ، يرجى المحاولة مرة أخرى");
    }
  }
}
