import 'package:get/get.dart';

class UserController extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://olat.vcrp.de';
  }

  Future<bool> login(String username, String password) async {
    try {
      final response = await post(
        '/remotelogin/',
        {
          "username": username,
          "pwd": password,
        },
        // Adding headers if required. Update accordingly.
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.isOk) {
        // If server returns a OK response, then login was successful
        return true;
      } else {
        // If server returns a non-OK response, then login failed
        return false;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return false;
    }
  }
}
