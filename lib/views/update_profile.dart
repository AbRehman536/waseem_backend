import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_backend/models/users.dart';
import 'package:firebase_backend/providers/user_provider.dart';
import 'package:firebase_backend/services/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;

  @override
  void initState(){
    var userProvider = Provider.of<UserProvider>(context);
    nameController = TextEditingController(
      text: userProvider.getUser().name.toString()
    );
    phoneController = TextEditingController(
      text: userProvider.getUser().phone.toString()
    );
    addressController = TextEditingController(
      text: userProvider.getUser().address.toString()
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        TextField(controller: nameController,
        decoration: InputDecoration(
          label: Text("Name")
        ),),
        TextField(controller: phoneController,
          decoration: InputDecoration(
              label: Text("Contact")
          ),),
        TextField(controller: addressController,
          decoration: InputDecoration(
              label: Text("Address")
          ),),
        isLoading ? Center(child: CircularProgressIndicator(),):
        ElevatedButton(onPressed: ()async{
          try{
            isLoading = false;
            setState(() {});
            await UserServices()
                .updateUser(UserModel(
              docId: userProvider.getUser().docId.toString(),
              name: nameController.text.toString(),
              phone: phoneController.text.toString(),
              address: addressController.text.toString()
            )).then((val)async{
              UserModel userModel = await UserServices()
                  .getUserById(
                userProvider.getUser().docId.toString(),);
              userProvider.setUser(UserModel());
              isLoading =false;
              setState(() {});
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("User updated successfully"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      },
                          child: Text("Okay"))
                    ],
                  );
                }, );
            });
          }catch(e){
            isLoading = false;
            setState(() {});
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }, child: Text("Update Profile"))
      ],),
    );
  }
}
