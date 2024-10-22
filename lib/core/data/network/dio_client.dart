// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:anime_app/core/data/network/interceptors/retry_on_connectivity_change_interceptor.dart';
import 'package:anime_app/core/error/exceptions.dart';
import 'package:dio/dio.dart';

import '../../host.dart';

abstract class Client {
  Future<T?> get<T>(String path);
  Future<T?> post<T>(String path, {Object data});
}

class DioClient extends Client {
  final Dio dio;
  final RetryOnConnectivityChangeInterceptor connectivityChangeInterceptor;
  DioClient({
    required this.dio,
    required this.connectivityChangeInterceptor,
  }) {
    dio.options = BaseOptions(
        baseUrl: Host.apiHost,
        connectTimeout: const Duration(seconds: 80),
        receiveTimeout: const Duration(seconds: 80),
        );

    dio.interceptors.add(connectivityChangeInterceptor);
    
  }

  @override
  Future<T?> get<T>(String path) async {
    try {
      final Response<T> response = await dio.get(path);

      if (response.statusCode == 200) {
        return response.data;
      }
      if (response.statusCode == 401) {
        throw NetworkException(type: NetworkExceptionType.unauthorized);
      }
      if (response.statusCode == 404) {
        throw NetworkException(type: NetworkExceptionType.notFound);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return null;
  }

  @override
  Future<T?> post<T>(String path, {Object? data}) async {
    Response<T> response = await dio.post(path, data: data);
    return response.data;
  }
}
