import 'package:dio/dio.dart';

abstract class Failure {
  String errMessage;

  Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad certificate');
      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode ?? 0;
        final data = dioError.response?.data;
        return ServerFailure.fromCode(statusCode, data);
      case DioExceptionType.cancel:
        return ServerFailure('Request was cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure(
          'Failed to connect. Please check your internet connection.',
        );
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          return ServerFailure('No Internet connection');
        }
        return ServerFailure(dioError.message ?? 'Unknown error occurred');
      // ignore: unreachable_switch_default
      default:
        return ServerFailure(dioError.message ?? 'Unexpected error');
    }
  }

  factory ServerFailure.fromCode(int code, dynamic response) {
    try {
      final message = response is Map && response['message'] is String
          ? response['message']
          : 'Something went wrong';

      switch (code) {
        case 400:
        case 401:
        case 403:
          return ServerFailure(message);
        case 404:
          return ServerFailure('The requested resource was not found');
        case 500:
          return ServerFailure('Internal server error');
        default:
          return ServerFailure('Unexpected server response ($code)');
      }
    } catch (_) {
      return ServerFailure('Unexpected error occurred');
    }
  }
}
