// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:anime_app/core/data/network/interceptors/dio_connectivity_request_retrier.dart';

class RetryOnConnectivityChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;
  RetryOnConnectivityChangeInterceptor({
    required this.requestRetrier,
  });
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      final response =
          await requestRetrier.sheduleRequestRetry(err.requestOptions);
      return handler.resolve(response);
    }
    return handler.next(err);
  }

  bool _shouldRetry(DioException exception) {
    return exception.type == DioExceptionType.connectionError &&
        exception.error != null &&
        exception.error is SocketException;
  }
}
