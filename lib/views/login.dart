import 'package:firebase_backend/services/auth.dart';
import 'package:firebase_backend/services/users.dart';
import 'package:flutter/material.dart';

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
                      await UserServices().getUserById(val.uid.toString())
                          .then((userData){
                            isLoading = false;
                            setState(() {});
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text("Link send Successfully"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("Okay"))
                              ],
                            );
                          },);
                      });
                });
              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
              }
        }, child: Text("Login"))
      ],),
    );
  }
}
