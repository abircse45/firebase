import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/screen/home_screen.dart';
import 'package:firebase_demo/screen/login_screen.dart';
import 'package:firebase_demo/screen/register_screen.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Mainpage(),
    );
  }
}
