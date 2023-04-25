import 'package:app_register_online/service/AuthProvider.dart';

import 'AdminHome.dart';
import 'Checking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/AppProvider.dart';
import 'Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    CheckLogin();
  }

  void CheckLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');

    // Provider.of<AppProvider>(context, listen: false).GetAllUser();
    Provider.of<AuthProvider>(context, listen: false)
        .CheckLoggin(token: token.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          if (auth.CheckLogin) {
            if (auth.isLoggin) {
              if (auth.isAdmin) {
                return AdminHome();
              } else {
                return Text('Loged');
              }
            } else {
              return Login();
            }
          } else {
            return CheckingPage();
          }
        },
      ),
    );
  }
}
