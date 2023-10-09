import 'package:dio/dio.dart';
import 'package:poke_app/services/api_endpoint.dart';
import 'package:poke_app/services/api_error_interceptor.dart';

class ApiClient {
  final _client = createDio();

  ApiClient._internal();

  static final _singleton = ApiClient._internal();

  factory ApiClient() => _singleton;

  static Dio createDio() {
    final dio = Dio(createBaseOptions());
    dio.interceptors.add(ApiErrorInterceptor(dio));
    return dio;
  }

  static BaseOptions createBaseOptions() => BaseOptions(
        baseUrl: ApiEndpoint.baseUrl,
        receiveTimeout: const Duration(seconds: 15),
        connectTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
        headers: {'Content-Type': 'application/json'},
      );

  Future<Response> get(String url, {Map<String, dynamic>? queryParams}) =>
      _client.get(url, queryParameters: queryParams);

  static ApiClient get instance {
    ApiClient defaultAppClientInstance = ApiClient();
    return defaultAppClientInstance;
  }
}
