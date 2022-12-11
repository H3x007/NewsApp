import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/v2/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> get({
    required String url,
    required dynamic query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
