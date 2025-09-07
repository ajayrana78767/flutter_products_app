import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppClient {
  final Dio dio;
  AppClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: "https://dummyjson.com/",
          connectTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30),
        ),
      ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('REQUEST');
          debugPrint('URL:${options.uri}');
          debugPrint('API METHOD:${options.method}');
          debugPrint('DATA:${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('RESPONSE');
          debugPrint('DATA: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          debugPrint('ERROR');
          debugPrint('Type: ${error.type}');
          if (error.response != null) {
            debugPrint(
              'Status: ${error.response?.statusCode}, Data: ${error.response?.data}',
            );
          }
          return handler.next(error);
        },
      ),
    );
  }
}
