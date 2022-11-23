import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
   bool loader = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
   final TextEditingController _firstnameController = TextEditingController();
   final TextEditingController _lastnameController = TextEditingController();
   final TextEditingController _ageController = TextEditingController();
   final TextEditingController _occuptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Register Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28, top: 60),
              child: TextField(
                controller: _firstnameController,
                decoration: InputDecoration(
                    hintText: "Firstname",
                    labelText: "Firstname",
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28, top: 20),
              child: TextField(
                controller: _lastnameController,
                decoration: InputDecoration(
                    hintText: "LastName",
                    labelText: "LastName",
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28, top: 20),
              child: TextField(
                controller: _ageController,
                decoration: InputDecoration(
                    hintText: "Age",
                    labelText: "Age",
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28, top: 20),
              child: TextField(
                controller: _occuptionController,
                decoration: InputDecoration(
                    hintText: "Occuption",
                    labelText: "Occuption",
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28, top: 20),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: "Email",
                    labelText: "Email",
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, right: 28, top: 20, bottom: 30),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    border: OutlineInputBorder()),
              ),
            ),
         loader ? Center(child: CircularProgressIndicator(),) :   ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.indigo),
              onPressed: () {
                registraion();
              },
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }


  Future registraion()async{
   try{
     setState(() {
       loader = true;
     });
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: _emailController.text,
       password: _passwordController.text,
     );

     // add user Details...
     addUserDetails();

     Fluttertoast.showToast(
         msg: "Successfully Registered",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 16.0
     );
     Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeSCreen()));

   } on FirebaseAuthException catch(errorMessage){

     setState(() {
       Fluttertoast.showToast(
           msg: "${errorMessage.message}",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 5,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
       loader = false;
     });
   }
  }

  Future addUserDetails()async{
    await FirebaseFirestore.instance.collection("users").add(
        {
      "first_name" : _firstnameController.text,
      "last_name" : _lastnameController.text,
      "age" : _ageController.text,
      "occuption" : _occuptionController.text,

    }
    );
  }

}
