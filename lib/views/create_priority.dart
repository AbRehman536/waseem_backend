import 'package:firebase_backend/services/priority.dart';
import 'package:flutter/material.dart';

import '../models/priority.dart';

class CreatePriority extends StatefulWidget {
  final PriorityModel model;
  final bool isUpdateMode;
  const CreatePriority({super.key, required this.model, required this.isUpdateMode});

  @override
  State<CreatePriority> createState() => _CreatePriorityState();
}

class _CreatePriorityState extends State<CreatePriority> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    if(widget.isUpdateMode == true){
   nameController = TextEditingController(
     text: widget.model.name.toString());
       }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdateMode ? "Update Priority" : "Create Priority"),
        backgroundColor: widget.isUpdateMode ? Colors.blue : Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        TextField(controller: nameController,),
        isLoading ? Center(child: CircularProgressIndicator(),):
        ElevatedButton(onPressed: ()async{
          try{
            isLoading = true;
            setState(() {});
            if(widget.isUpdateMode){
              await PriorityServices().updatePriority(PriorityModel(
                name: nameController.text.toString(),
                docId: widget.model.docId,
                createdAt: DateTime.now().millisecondsSinceEpoch,
              )).then((val){
                showDialog(context: context, 
                  builder: (BuildContext context) { 
                  return AlertDialog(
                    content: Text(widget.isUpdateMode
                        ? "Priority has been updated successfully"
                      : "Priority has been created successfully",),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("Back")),
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("Next")),
                    ],
                  );
                  }, );
              });
            }
            else{
              await PriorityServices().createPriority(PriorityModel(
                name: nameController.text.toString(),
                createdAt: DateTime.now().millisecondsSinceEpoch
              )).then((val){
                showDialog(context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(widget.isUpdateMode
                          ? "Priority has been updated successfully"
                          : "Priority has been created successfully",),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Okay")),

                      ],
                    );
                  }, );
              });
            }
          }
          catch(e){
            isLoading = false;
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
          }

        },
            child: Text(widget.isUpdateMode == true ? "Update Priority": "Create Priority"))
      ],),
    );
  }
}
