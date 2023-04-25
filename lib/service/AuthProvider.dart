import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import '../model/User.dart';
import 'Dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoggin = false; // ກວດຊອບການ ເຂົ້າສູ່ລະບົບ
  String? _token; // ເກັບ Token
  bool CheckLogin = false; // ສະແດງໜ້າ ກວດຊອບ Login
  bool isAdmin = true; // ເຊັກວ່າແມ່ນ admin ບໍ່
  String? massages_check_login; //
  User? user_login;
  bool Loading_list_contact = false; //  ສະຖານະໂຫລດຂໍ້ມູນ

  // Admin tabmenu

  int AdminPage = 0;

  void SetAdminPage(int page) {
    AdminPage = page;
    notifyListeners();
  }

  void CheckLoggin({required String token}) async {
    CheckLogin = false;
    notifyListeners();
    var Token1 = token.replaceAll('\n', '');
    var newToken = Token1.replaceAll('\r', '');

    final response = await dio().get('/get_user',
        options: Options(headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Bearer $newToken",
        }, validateStatus: ((status) => true)));
    print(newToken);
    if (response.statusCode == 200) {
      Map<String, dynamic> dcode = response.data;
      this.user_login = User.fromJson(dcode['user']);
      // GetAllUser();
      // print(_user_login!.name);
      isLoggin = true;
      CheckLogin = true;
      notifyListeners();
    } else {
      isLoggin = false;
      CheckLogin = true;
      print(response.data);
      notifyListeners();
    }
  }

  Future<bool> LoginAuth(TelLogin, Password) async {
    Map creds = {
      'tel': TelLogin,
      'password': Password,
      'device_name': await getDeviceId(),
    };

    // print('Login: ' + _allloan.toString());

    final response = await dio().post('/login',
        data: creds, options: Options(validateStatus: ((status) => true)));
    print(response.statusCode);

    if (response.statusCode == 200) {
      String token = response.data.toString();
      await saveToken(token);
      this._token = token;
      this.isLoggin = true;

      CheckLoggin(token: token);

      notifyListeners();
      return true;
    }

    if (response.statusCode == 422) {
      Map<String, dynamic> dcode = response.data;
      massages_check_login = 'ລະຫັດຜ່ານບໍ່ຖຶກຕ້ອງ! ກະລຸນາກວດຄືນ...';
      notifyListeners();
      return false;
    }

    return false;
  }

  Future<bool> LoginOut() async {
    CheckLogin = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    var Token1 = token!.replaceAll('\n', '');
    var newToken = Token1.replaceAll('\r', '');

    final response = await dio().get('/user/logout',
        options: Options(headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Bearer $newToken",
        }, validateStatus: ((status) => true)));

    print(response.statusCode);

    if (response.statusCode == 200) {
      cleanUp();
      return true;
    }

    return false;
  }

  // ບັນທຶກ token
  saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // ດຶງຂໍ້ມູນແພັດຟອມ
  getDeviceId() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        return build.androidId;
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        return data.identifierForVendor;
      } else {
        return 'no';
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  cleanUp() async {
    final prefs = await SharedPreferences.getInstance();

    // CheckLogin = false;
    isLoggin = false;
    // CheckLogin = false;
    // ListUser = [];
    print('remove ok!');
    _token = null;
    await prefs.remove('token');
    notifyListeners();

    // await prefs.remove('app_page');
  }
}
