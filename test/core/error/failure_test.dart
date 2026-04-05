import 'package:al_huda/core/error/failure.dart';
import 'package:al_huda/core/error/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Result', () {
    test('Success should contain data', () {
      const result = Success('test_data');
      expect(result.data, 'test_data');
      expect(result, isA<Success<String>>());
    });

    test('Error should contain Failure', () {
      const failure = ServerFailure('test_error');
      const result = Error(failure);
      expect(result.failure, failure);
      expect(result, isA<Error<dynamic>>());
    });
  });

  group('Failure', () {
    test('ServerFailure props should contain errMessage', () {
      const failure = ServerFailure('error');
      expect(failure.props, ['error']);
    });

    test('CacheFailure props should contain errMessage', () {
      const failure = CacheFailure('cache_error');
      expect(failure.props, ['cache_error']);
    });

    test('ParsingFailure props should contain errMessage', () {
      const failure = ParsingFailure('parsing_error');
      expect(failure.props, ['parsing_error']);
    });

    group('ServerFailure.fromDioError', () {
      test('handles connectionTimeout', () {
        final dioError = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionTimeout,
        );
        final failure = ServerFailure.fromDioError(dioError);
        expect(failure.errMessage, 'Connection timeout');
      });

      test('handles SocketException wrapped in DioException', () {
        final dioError = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.unknown,
          message: 'SocketException: Failed host lookup',
        );
        final failure = ServerFailure.fromDioError(dioError);
        expect(failure.errMessage, 'No Internet connection');
      });
    });

    group('ServerFailure.fromCode', () {
      test('handles 404', () {
        final failure = ServerFailure.fromCode(404, null);
        expect(failure.errMessage, 'The requested resource was not found');
      });

      test('handles 500', () {
        final failure = ServerFailure.fromCode(500, null);
        expect(failure.errMessage, 'Internal server error');
      });

      test('handles expected map message', () {
        final failure = ServerFailure.fromCode(400, {'message': 'Bad request input'});
        expect(failure.errMessage, 'Bad request input');
      });
    });
  });
}
