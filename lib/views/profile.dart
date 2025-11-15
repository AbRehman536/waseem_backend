import 'package:firebase_backend/providers/user_provider.dart';
import 'package:firebase_backend/views/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        Text("Name: ${userProvider.getUser().name.toString()}",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),),
        Text("Email: ${userProvider.getUser().email.toString()}",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),),
        Text("Phone: ${userProvider.getUser().phone.toString()}",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),),
        Text("Address: ${userProvider.getUser().address.toString()}",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfile()));
        }, child: Text("Update Profile"))
      ],),
    );
  }
}
