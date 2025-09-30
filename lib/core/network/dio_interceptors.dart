import 'package:dio/dio.dart';

/// Interceptor để log request/response
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("[REQUEST] ${options.uri}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("[RESPONSE] ${response.statusCode} => ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("[ERROR] ${err.message}");
    super.onError(err, handler);
  }
}