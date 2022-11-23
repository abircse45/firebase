import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/screen/home_screen.dart';
import 'package:firebase_demo/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loader = false;
  bool checkPassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Login Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

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
                obscureText: checkPassword,
                controller: _passwordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    border: OutlineInputBorder(),
                     suffixIcon: GestureDetector(
                       onTap: (){
                         showPassword();
                       },
                         child: checkPassword  ? Icon(Icons.visibility_off) : Icon(Icons.visibility)),
                ),
              ),
            ),
            loader ? Center(child: CircularProgressIndicator(),) :
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.indigo),
              onPressed: () {
                LoginMethod();
              },
              child: Text("Login"),
            ),
            
            SizedBox(height: 20,),

            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.indigo),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen() ));
              },
              child: Text("Register Page"),
            ),
          ],
        ),
      ),
    );
  }

  showPassword(){
    setState(() {
      checkPassword = !checkPassword;
    });

  }


  Future LoginMethod()async{
    try{
      setState(() {
        loader = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Fluttertoast.showToast(
          msg: "Successfully Login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // add User..

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


}
