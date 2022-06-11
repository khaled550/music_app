import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://api.musixmatch.com/ws/1.1/', receiveDataWhenStatusError: true));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
    return await dio.get(url, queryParameters: query);
  }
}
