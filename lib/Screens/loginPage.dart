import 'package:flutter/material.dart';
import 'package:register_with_course_sqflite/Database_sqflite/dataBase.dart';
import 'package:register_with_course_sqflite/Screens/registerPage.dart';

import 'home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formkey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 180),
            child: Column(
              children: [
                Icon(
                  Icons.telegram,
                  color: Colors.white,
                  size: 90,
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      )),
                  validator: (email) {
                    if (email!.isEmpty &&
                        email.contains("@") &&
                        email.contains(".")) return "Invalid username";
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                        hintText: "password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        )),
                    validator: (password) {
                      if (password!.isEmpty || password.length < 6)
                        return "Invalid password";
                    }),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    final valid = formkey.currentState!.validate();

                    if (valid) {
                      loginCheck(email.text, password.text);
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white54,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)),
                    minimumSize: Size(370, 60),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 90,
                    ),
                    Text(
                      "Create an account !",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.bold),
                        ),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginCheck(String email, String password) async {
    var data = await SqflDataBase.CheckLogin(email, password);
    if (data.isNotEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }
}
