import 'package:firebase_backend/models/users.dart';
import 'package:firebase_backend/services/auth.dart';
import 'package:firebase_backend/services/users.dart';
import 'package:firebase_backend/views/login.dart';
import 'package:flutter/material.dart';

class Registeration extends StatefulWidget {
  const Registeration({super.key});

  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Column(children: [
        TextField(
          controller: nameController,
        decoration: InputDecoration(label: Text("Username")),),
        TextField(controller: emailController,
          decoration: InputDecoration(label: Text("Email")),),
        TextField(controller: passwordController,
          decoration: InputDecoration(label: Text("Password")),),
        TextField(controller: cpasswordController,
          decoration: InputDecoration(label: Text("Confirm Password")),),
        TextField(controller: phoneController,
          decoration: InputDecoration(label: Text("Contact")),),
        TextField(controller: addressController,
          decoration: InputDecoration(label: Text("Address")),),
        isLoading? Center(child: CircularProgressIndicator(),)
        :ElevatedButton(onPressed: ()async{
          try{
            isLoading = true;
            setState(() {});
            await AuthServices().registerUser(
                email: emailController.text, password: passwordController.text)
                .then((user) async{
                  await UserServices().createUser(UserModel(
                    docId: user.uid.toString(),
                    name: nameController.text.toString(),
                    email: emailController.text.toString(),
                    phone: phoneController.text.toString(),
                    address: addressController.text.toString(),
                    createdAt: DateTime.now().millisecondsSinceEpoch
                  )).then((val){
                    isLoading = false;
                    setState(() {});
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Register Successfully"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
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
        }, child: Text("Register"))
      ],),
    );
  }
}
