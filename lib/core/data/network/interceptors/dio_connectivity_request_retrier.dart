// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:anime_app/core/platform/network_info.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final NetworkInfo networkInfo;
  DioConnectivityRequestRetrier({
    required this.dio,
    required this.networkInfo,
  });
  Future<Response> sheduleRequestRetry(RequestOptions requestOptions) async {
    final responseCompleter = Completer<Response>();
    late final StreamSubscription<bool> subcription;
    subcription = networkInfo.watchConnection.listen((isConnection) {
      if (isConnection) {
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
