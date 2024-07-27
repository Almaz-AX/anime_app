// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';
import 'package:anime_app/core/data/network/interceptors/retry_on_connectivity_change_interceptor.dart';
import 'package:anime_app/core/error/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../host.dart';

class DioClient {
  final Dio dio;
  final RetryOnConnectivityChangeInterceptor connectivityChangeInterceptor;
  DioClient({
    required this.dio,
    required this.connectivityChangeInterceptor,
  }) {
    dio.options = BaseOptions(
        baseUrl: Host.apiHost,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30));

    dio.interceptors.add(connectivityChangeInterceptor);
  }

  Future<T?> get<T>(String path) async {
    try {
      if (Platform.isAndroid) {
        (dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
          final HttpClient client = HttpClient();
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        }));
      }

      final Response<T> response = await dio.get(path);
      print(response);
      if (response.statusCode == 200) {
        return response.data;
      }
      if (response.statusCode == 401) {
        throw NetworkException(type: NetworkExceptionType.unauthorized);
      }
      // Не ловится ошибка!!!!!!!!!!!
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return null;
  }
}
