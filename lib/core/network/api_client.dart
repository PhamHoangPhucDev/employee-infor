// lib/core/network/api_client.dart
import 'package:dio/dio.dart';

import 'dio_interceptors.dart';

class ApiClient {
  final Dio dio;

   ApiClient({String? baseUrl})
      : dio = Dio(BaseOptions(
          baseUrl: baseUrl ?? 'http://192.168.2.137:8000',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
          responseType: ResponseType.json,
        )) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Có thể thêm token header ở đây nếu cần: options.headers['Authorization'] = 'Bearer ...'
        // ignore: avoid_print
        LoggingInterceptor().onRequest(options, handler);
        // return handler.next(options);
      },
      onResponse: (response, handler) {
        // ignore: avoid_print
        LoggingInterceptor().onResponse(response, handler);
        // return handler.next(response);
      },
      onError: (err, handler) {
        // ignore: avoid_print
        LoggingInterceptor().onError(err, handler);
        // return handler.next(err);
      },
    ));
  }

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query}) {
    return dio.get(path, queryParameters: query);
  }

  Future<Response<T>> post<T>(String path, {dynamic data}) {
    return dio.post(path, data: data);
  }
}
