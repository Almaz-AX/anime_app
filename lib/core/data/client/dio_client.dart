// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:anime_app/core/error/expetions.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../host.dart';

class DioClient {
  final Dio dio;
  final HttpClient client2 = HttpClient();
  DioClient({
    required this.dio,
  }) {
    dio.options.baseUrl = Host.apiHost;
  }

  Future<dynamic> get(String path) async {
    if (Platform.isAndroid) {
      (dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
        final HttpClient client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      }));
    }
    final response = await dio.get(path);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ServerExeption();
    }
  }
}
