import 'package:firebase_backend/models/users.dart';
import 'package:firebase_backend/services/auth.dart';
import 'package:firebase_backend/services/users.dart';
import 'package:firebase_backend/views/registeration.dart';
import 'package:firebase_backend/views/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Form"),
      ),
      body: Column(children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            label: Text("Email"),
          ),
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            label: Text("Password"),
          ),
        ),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading = true;
                setState(() {});
                await AuthServices().loginUser(
                    email: emailController.text, password: passwordController.text)
                    .then((val)async{
                  UserModel userModel = await UserServices()
                      .getUserById(val.uid.toString());
                  userProvider.setUser(userModel);
                            isLoading = false;
                            setState(() {});
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text("${userModel.name} has been logged in successfully"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("Okay"))
                              ],
                            );
                          },);
                });
              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
              }
        }, child: Text("Login")),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Registeration()));
        }, child: Text("Sign UP")),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));

        }, child: Text("Forget Password")),
      ],),
    );
  }
}
