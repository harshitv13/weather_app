import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static saveToken(String tokenValue) {
    return GetStorage().write("token", tokenValue);
  }

  static getToken() {
    return GetStorage().read("token");
  }

  deleteToken() {
    return GetStorage().remove("token");
  }

  static saveUsername(String userName) {
    return GetStorage().write('name', userName);
  }

  static getUsername() {
    return GetStorage().read('name');
  }
}
