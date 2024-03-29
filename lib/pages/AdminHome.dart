import 'package:app_register_online/service/AppProvider.dart';
import 'package:app_register_online/service/ContactProvider.dart';
import 'package:flutter/material.dart';
import '../service/AuthProvider.dart';
import 'ListContact.dart';
import 'Form.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  // int _selectedIndex = 0;

  void _onItemTapped(int index) {
    Provider.of<AuthProvider>(context, listen: false).SetAdminPage(index);
    //setState(() {
    //  print(Provider.of<AppProvider>(context, listen: false).isAdmin);
    // _selectedIndex = index;
    //});
  }

  static const List<Widget> _widgetOptions = <Widget>[
    ListContact(),
    FormAdd(
      UserID: 0,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, Auth, child) {
        return Scaffold(
          body: SafeArea(
              child: _widgetOptions.elementAt(
                  Provider.of<AuthProvider>(context, listen: false).AdminPage)),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 238, 43, 153),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'ລາຍການສະມາຊິກ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.plus_one),
                label: 'ເພີ່ມສະມາຊິກໃໝ່',
              ),
            ],
            currentIndex:
                Provider.of<AuthProvider>(context, listen: false).AdminPage,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey[400],
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
