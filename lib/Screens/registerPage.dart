import 'package:flutter/material.dart';
import 'package:register_with_course_sqflite/Database_sqflite/dataBase.dart';
import 'package:register_with_course_sqflite/Screens/loginPage.dart';

// void main(){
//   runApp(MaterialApp(debugShowCheckedModeBanner: false,
//     home: RegisterPage(),));
// }

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var formkey1 =GlobalKey<FormState>();
  var name =TextEditingController();
  var email =TextEditingController();
  var password =TextEditingController();
  var course =TextEditingController();
  var gender =TextEditingController();
  var confmPasswd =TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: SingleChildScrollView(
        child: Form(
          key: formkey1,
          child: Padding(
            padding: const EdgeInsets.only(left: 25,right: 25,top: 100),
            child: Column(
              children: [
                Icon(Icons.telegram,color: Colors.white,size: 90,),

                SizedBox(height: 40,),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                      hintText: "Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(18),
                      )
                  ),
                  validator: (username){
                    if(username!.isEmpty)
                      return"Invalid username";
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(18),
                        )
                    ),
                    validator:(email){
                      if(email!.isEmpty && email.contains("@" ) && email.contains("."))
                        return"Invalid password";
                    }
                ),
                SizedBox(height: 10,),
                TextFormField(
                    controller: course,
                    decoration: InputDecoration(
                        hintText: "Course",
                        prefixIcon: Icon(Icons.school),
                        border: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(18),
                        )
                    ),
                    validator:(course){
                      if(course!.isEmpty )
                        return"Invalid field";
                    }
                ),
                SizedBox(height: 10,),
                TextFormField(
                    controller: gender,
                    decoration: InputDecoration(
                        hintText: "Gender",
                        prefixIcon: Icon(Icons.transgender),
                        border: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(18),
                        )
                    ),
                    validator:(gender){
                      if(gender!.isEmpty)
                        return"Invalid password";
                    }
                ),SizedBox(height: 10,),
                TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",

                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(18),
                        )
                    ),
                    validator:(password){
                      if(password!.isEmpty && password.length<6)
                        return"Invalid password";
                    }
                ),
                SizedBox(height: 10,),
                TextFormField(
                  obscureText: true,
                    controller: confmPasswd,
                    decoration: InputDecoration(
                        hintText: "Confirm Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(18),
                        )
                    ),
                    validator:(confrmPassword){
                      if(confrmPassword!.isEmpty || confrmPassword.length<6 && confmPasswd==password)
                        return"Invalid password";
                    }
                ),

                SizedBox(height: 40,),
                ElevatedButton(onPressed: ()async{

                  final valid=  formkey1.currentState!.validate();
                  if(valid){
                    String Email= email.text;
                    var data=await SqflDataBase.checkUser(Email);

                    if(data.isNotEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("User Already Exits!!")));
                    }
                    else
                      {
                        AddUser(name.text,email.text,course.text,gender.text,password.text);
                      }
                  }

                },


                  child: Text("Register",style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,color: Colors.black
                  ),),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white54,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                    minimumSize: Size(370, 60),),),

                SizedBox(height: 70,),
                Row(
                  children: [
                    SizedBox(width: 90,),
                    Text("Create an account !",style: TextStyle(fontWeight: FontWeight.bold),),
                    TextButton(onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    }, child: Text("Login",style: TextStyle(color: Colors.white54,fontWeight: FontWeight.bold),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void AddUser(String name, String email, String course, String gender, String password)async {
    var id =await SqflDataBase.addNewuser(name, email, course, gender, password);
    if(id !=null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }
  }
}
