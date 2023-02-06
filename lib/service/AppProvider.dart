import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/User.dart';
import 'Dio.dart';
import 'package:dio/dio.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
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

  // list contact
  List<User> ListUser = [];
  List<User> ListUserSearch = [];

  void AddListUser(User _user) {
    ListUser.add(_user);
    notifyListeners();
  }

  void UpdateUser(User _user) {
    ListUser[0] = _user;
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

    if (response.statusCode == 200) {
      Map<String, dynamic> dcode = response.data;
      this.user_login = User.fromJson(dcode['user']);
      GetAllUser();
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

  void GetAllUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    if (token == null) {
      Loading_list_contact = false;
      notifyListeners();
    } else {
      var Token1 = token.replaceAll('\n', '');
      var newToken = Token1.replaceAll('\r', '');

      Loading_list_contact = true;
      notifyListeners();

      final response = await dio().get('/get_all_user',
          options: Options(headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer $newToken",
          }, validateStatus: ((status) => true)));

      if (response.statusCode == 200) {
        ListUser = [];
        Map<String, dynamic> dcode = response.data;

        for (var item in dcode['user']) {
          User _listUser = User(
              id: item['id'],
              name: item['name'].toString(),
              last_name: item['last_name'].toString(),
              gender: item['gender'].toString(),
              image: item['image'].toString(),
              tel: item['tel'].toString(),
              password: '',
              birth_day: item['birth_day'].toString(),
              add_village: item['add_village'].toString(),
              add_city: item['add_city'].toString(),
              add_province: item['add_province'].toString(),
              add_detail: item['add_detail'].toString(),
              email: item['email'].toString(),
              web: item['web'].toString(),
              job: item['job'].toString(),
              job_type: item['job_type'].toString(),
              user_type: item['user_type'].toString());
          AddListUser(_listUser);
        }
        ListUserSearch = ListUser;
        print(ListUser.length);
        Loading_list_contact = false;
        notifyListeners();
      } else {
        Loading_list_contact = false;
        notifyListeners();
      }
    }
  }

  // Search Data

  void SearchContact(String value) {
    print(value);
    List<User> Search = [];
    if (value.isNotEmpty) {
      final Scon = ListUser.where((item) {
        final name = item.name.toLowerCase();
        final input = value.toLowerCase();
        return name.contains(input);
      }).toList();
      ListUserSearch = Scon;
      notifyListeners();
    } else {
      ListUserSearch = ListUser;
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

  Future<bool> AddUser(
      String name,
      String lastName,
      String gender,
      String email,
      String web,
      String birthDay,
      String phoneNumber,
      String password,
      String job,
      String jobType,
      String addVillage,
      String addCity,
      String addProvince,
      String addDetail,
      File? imageFile) async {
    if (imageFile == null) {
      //  String fileName = imageFile!.path.split('/').last;
      FormData DataAddUser = FormData.fromMap({
        'name': name,
        'last_name': lastName,
        'gender': gender,
        'email': email,
        'web': web,
        'birth_day': birthDay,
        'tel': phoneNumber,
        'password': password,
        'job': job,
        'job_type': jobType,
        'add_village': addVillage,
        'add_city': addCity,
        'add_province': addProvince,
        'add_detail': addDetail,
        // 'image': ''
      });

      final prefs = await SharedPreferences.getInstance();
      String? token = await prefs.getString('token');
      var Token1 = token!.replaceAll('\n', '');
      var newToken = Token1.replaceAll('\r', '');

      final response = await dio().post('/register_user',
          data: DataAddUser,
          options: Options(headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer $newToken",
          }, validateStatus: ((status) => true)));

      print(response.data);

      if (response.statusCode == 200) {
        SetAdminPage(0);
        GetAllUser();
        notifyListeners();
        return true;
      }
    } else {
      String fileName = imageFile.path.split('/').last;
      FormData DataAddUser = FormData.fromMap({
        'name': name,
        'last_name': lastName,
        'gender': gender,
        'email': email,
        'web': web,
        'birth_day': birthDay,
        'tel': phoneNumber,
        'password': password,
        'job': job,
        'job_type': jobType,
        'add_village': addVillage,
        'add_city': addCity,
        'add_province': addProvince,
        'add_detail': addDetail,
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        )
      });

      final prefs = await SharedPreferences.getInstance();
      String? token = await prefs.getString('token');
      var Token1 = token!.replaceAll('\n', '');
      var newToken = Token1.replaceAll('\r', '');

      final response = await dio().post('/register_user',
          data: DataAddUser,
          options: Options(headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer $newToken",
          }, validateStatus: ((status) => true)));

      print(response.data);

      if (response.statusCode == 200) {
        SetAdminPage(0);
        GetAllUser();
        notifyListeners();
        return true;
      }
    }

    return false;
  }

  Future<bool> UpdateUserEdit(
      int UserID,
      String name,
      String lastName,
      String gender,
      String email,
      String web,
      String birthDay,
      String phoneNumber,
      String password,
      String job,
      String jobType,
      String addVillage,
      String addCity,
      String addProvince,
      String addDetail,
      File? imageFile) async {
    // Map DataAddUser = {
    //   'name': name,
    //   'last_name': lastName,
    //   'gender': gender,
    //   'email': email,
    //   'web': web,
    //   'birth_day': birthDay,
    //   'tel': phoneNumber,
    //   'password': password,
    //   'job': job,
    //   'job_type': jobType,
    //   'add_village': addVillage,
    //   'add_city': addCity,
    //   'add_province': addProvince,
    //   'add_detail': addDetail,
    // };

    print(imageFile);

    if (imageFile == null) {
      //  String fileName = imageFile!.path.split('/').last;

      FormData DataAddUser = FormData.fromMap({
        'name': name,
        'last_name': lastName,
        'gender': gender,
        'email': email,
        'web': web,
        'birth_day': birthDay,
        'tel': phoneNumber,
        'password': password,
        'job': job,
        'job_type': jobType,
        'add_village': addVillage,
        'add_city': addCity,
        'add_province': addProvince,
        'add_detail': addDetail,
        // 'image': ''
      });

      // print('Login: ' + _allloan.toString());

      final prefs = await SharedPreferences.getInstance();
      String? token = await prefs.getString('token');
      var Token1 = token!.replaceAll('\n', '');
      var newToken = Token1.replaceAll('\r', '');

      final response = await dio().post('/update_user/${UserID}',
          data: DataAddUser,
          options: Options(headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer $newToken",
          }, validateStatus: ((status) => true)));

      print(response.data['success']);

      // update user login
      CheckLoggin(token: token);

      if (response.statusCode == 200) {
        SetAdminPage(0);
        GetAllUser();
        notifyListeners();
        return true;
      }
    } else {
      String fileName = imageFile.path.split('/').last;

      FormData DataAddUser = FormData.fromMap({
        'name': name,
        'last_name': lastName,
        'gender': gender,
        'email': email,
        'web': web,
        'birth_day': birthDay,
        'tel': phoneNumber,
        'password': password,
        'job': job,
        'job_type': jobType,
        'add_village': addVillage,
        'add_city': addCity,
        'add_province': addProvince,
        'add_detail': addDetail,
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        )
      });

      // print('Login: ' + _allloan.toString());

      final prefs = await SharedPreferences.getInstance();
      String? token = await prefs.getString('token');
      var Token1 = token!.replaceAll('\n', '');
      var newToken = Token1.replaceAll('\r', '');

      final response = await dio().post('/update_user/${UserID}',
          data: DataAddUser,
          options: Options(headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer $newToken",
          }, validateStatus: ((status) => true)));

      print(response.data['success']);

      // update user login
      CheckLoggin(token: token);

      if (response.statusCode == 200) {
        SetAdminPage(0);
        GetAllUser();
        notifyListeners();
        return true;
      }
    }

    return false;
  }

  Future<bool> DeleteUser(int UserID) async {
    CheckLogin = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    var Token1 = token!.replaceAll('\n', '');
    var newToken = Token1.replaceAll('\r', '');

    final response = await dio().delete('/user/delete/${UserID}',
        options: Options(headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Bearer $newToken",
        }, validateStatus: ((status) => true)));

    print(response.statusCode);

    if (response.statusCode == 200) {
      // cleanUp();
      GetAllUser();
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
    ListUser = [];
    print('remove ok!');
    _token = null;
    await prefs.remove('token');
    notifyListeners();

    // await prefs.remove('app_page');
  }
}
