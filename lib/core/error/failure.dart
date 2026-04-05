import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errMessage;

  const Failure(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}

class ServerFailure extends Failure {
  const ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('Connection timeout');
      case DioExceptionType.sendTimeout:
        return const ServerFailure('Send timeout');
      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Receive timeout');
      case DioExceptionType.badCertificate:
        return const ServerFailure('Bad certificate');
      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode ?? 0;
        final data = dioError.response?.data;
        return ServerFailure.fromCode(statusCode, data);
      case DioExceptionType.cancel:
        return const ServerFailure('Request was cancelled');
      case DioExceptionType.connectionError:
        return const ServerFailure(
          'Failed to connect. Please check your internet connection.',
        );
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          return const ServerFailure('No Internet connection');
        }
        return ServerFailure(dioError.message ?? 'Unknown error occurred');
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
          return const ServerFailure('The requested resource was not found');
        case 500:
          return const ServerFailure('Internal server error');
        default:
          return ServerFailure('Unexpected server response ($code)');
      }
    } catch (_) {
      return const ServerFailure('Unexpected error occurred');
    }
  }
}

class CacheFailure extends Failure {
  const CacheFailure(super.errMessage);
}

class ParsingFailure extends Failure {
  const ParsingFailure(super.errMessage);
}
