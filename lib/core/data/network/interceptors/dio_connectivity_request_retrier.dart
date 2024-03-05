// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;
  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });
  Future<Response> sheduleRequestRetry(RequestOptions requestOptions) async {
    final responseCompleter = Completer<Response>();
    late final StreamSubscription<ConnectivityResult> subcription;
    subcription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult != ConnectivityResult.none) {
        responseCompleter.complete(dio.request(
          requestOptions.path,
          cancelToken: requestOptions.cancelToken,
          data: requestOptions.data,
          onReceiveProgress: requestOptions.onReceiveProgress,
          onSendProgress: requestOptions.onSendProgress,
          queryParameters: requestOptions.queryParameters,
        ));
        subcription.cancel();
      }
    });

    return responseCompleter.future;
  }
}
