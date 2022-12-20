import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class DioFactory {
  static Dio newInstance({required String baseUrl}) {
    final dio = Dio(_options(baseUrl));
    dio.interceptors
        .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
    // Add Auth interceptors
    return dio;
  }

  static BaseOptions _options(String baseUrl) => BaseOptions(baseUrl: baseUrl);
}
