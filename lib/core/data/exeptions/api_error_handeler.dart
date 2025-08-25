import 'dart:io';
import 'package:al_huda/core/data/response/error_response.dart';
import 'package:dio/dio.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";

    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioExceptionType.connectionTimeout:
              errorDescription = "Connection timeout";
              break;
            case DioExceptionType.receiveTimeout:
              errorDescription =
                  "Receive timeout in connection with API server";
              break;
            case DioExceptionType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
            case DioExceptionType.badCertificate:
              errorDescription = "Bad SSL Certificate";
              break;
            case DioExceptionType.connectionError:
              if (error.error is SocketException) {
                errorDescription = "No internet connection";
              } else {
                errorDescription = "Connection error occurred";
              }
              break;
            case DioExceptionType.unknown:
              if (error.error is SocketException) {
                errorDescription = "No internet connection";
              } else {
                errorDescription = "Unknown error occurred";
              }
              break;

            case DioExceptionType.badResponse:
              switch (error.response?.statusCode) {
                case 404:
                case 500:
                case 503:
                  errorDescription = "There is a problem with the server";
                  break;

                case 422:
                  Error401Response error422Response = Error401Response.fromJson(
                    error.response?.data,
                  );
                  if (error422Response.code == 422) {
                    errorDescription = error422Response.message.toString();
                  } else {
                    errorDescription = "Unprocessable entity";
                  }
                  break;

                case 401:
                  Error401Response error401Response = Error401Response.fromJson(
                    error.response?.data,
                  );
                  if (error401Response.code == 401) {
                    errorDescription = error401Response.message.toString();
                  } else {
                    errorDescription = "Unauthorized request";
                  }
                  break;

                default:
                  ErrorResponse errorResponse = ErrorResponse.fromJson(
                    error.response?.data,
                  );
                  if (errorResponse.errors != null &&
                      errorResponse.errors!.isNotEmpty) {
                    errorDescription = errorResponse;
                  } else {
                    errorDescription =
                        "Server error - ${error.response?.statusCode}";
                  }
              }
              break;
          }
        } else if (error is SocketException) {
          errorDescription = "No internet connection";
        } else {
          errorDescription = "Unexpected error occurred";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "Unknown error type";
    }

    return errorDescription;
  }
}
