import '../utils/local_storage.dart';

class AuthService {
  static Future<void> login(String email, String password) async {
    // Simulate a login by saving a token
    await LocalStorage.saveToken('sample_token');
  }

  static Future<void> logout() async {
    await LocalStorage.clearToken();
  }
}
