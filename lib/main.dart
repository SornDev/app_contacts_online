import 'package:app_register_online/service/AppProvider.dart';
import 'package:app_register_online/service/AuthProvider.dart';
import 'package:app_register_online/service/ContactProvider.dart';
import 'package:flutter/material.dart';
import 'pages/MainApp.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => ContactProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Register Online',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'BoonBaan',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          bodyText1: TextStyle(fontSize: 14, fontFamily: 'Hind'),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MainApp(),
    );
  }
}
