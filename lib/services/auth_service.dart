import 'package:recepie_app/models/user.dart';
import 'package:recepie_app/services/http_service.dart';

class AuthService {
  static final AuthService singleton = AuthService.internal();

  final httpService = HTTPService();
  Users? user;
  factory AuthService() {
    return singleton;
  }
  AuthService.internal();

  Future<bool> login(String username, String password) async {
    try {
      var response = await httpService.post("auth/login", {
        "username": username,
        "password": password,
      });
      if (response?.statusCode == 200 && response?.data != null) {
        user = Users.fromJson(response!.data);
        HTTPService().setup(bearerToken: user!.token);
        return true;
      }
    } catch (e) {
      // print(e);
    }
    return false;
  }
}
