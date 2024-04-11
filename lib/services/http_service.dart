import 'package:dio/dio.dart';
import 'package:recepie_app/consts.dart';

class HTTPService {
  static final HTTPService singleton = HTTPService.internal();

  final dio = Dio();

  factory HTTPService() {
    return singleton;
  }
  HTTPService.internal() {
    setup();
  }

  Future<void> setup({String? bearerToken}) async {
    final headers = {
      "Content-Type": "application/json",
    };
    if (bearerToken != null) {
      headers["Authorization"] = "Bearer $bearerToken";
    }
    final options = BaseOptions(
      baseUrl: API_BASE_URL,
      headers: headers,
      validateStatus: (status) {
        if (status == null) return false;
        return status < 500;
      },
    );
    dio.options = options;
  }

  Future<Response?> post(String path, Map data) async {
    try {
      final response = await dio.post(
        path,
        data: data,
      );
      return response;
    } catch (e) {
      // print(e);
    }
    return null;
  }

  Future<Response?> get(String path) async {
    try {
      final response = await dio.get(path);
      return response;
    } catch (e) {
      // print(e);
    }
    return null;
  }
}
