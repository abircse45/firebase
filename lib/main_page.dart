import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/screen/home_screen.dart';
import 'package:firebase_demo/screen/login_screen.dart';
import 'package:flutter/material.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return HomeSCreen();
          }else{
            return LoginScreen();
          }
        },
      ),

    );
  }
}
