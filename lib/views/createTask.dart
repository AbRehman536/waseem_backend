import 'package:firebase_backend/models/task.dart';
import 'package:firebase_backend/services/task.dart';
import 'package:flutter/material.dart';

class Createtask extends StatefulWidget {
  const Createtask({super.key});

  @override
  State<Createtask> createState() => _CreatetaskState();
}

class _CreatetaskState extends State<Createtask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        TextField(controller: titleController,),
        TextField(controller: descriptionController,),
        isLoading ? Center(child: CircularProgressIndicator(),)
        : ElevatedButton(onPressed: ()async{
          try{
            isLoading = true;
            setState(() {});
            await TaskServices()
                .createTask(TaskModel(
              title: titleController.text.toString(),
              description: descriptionController.text.toString(),
              isCompleted: false,
              createdAt: DateTime.now().millisecondsSinceEpoch,
            )).then((val){
              isLoading = false;
              setState(() {});
              return showDialog(
                  context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text("Task Created Successfully"),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Okay"))
                      ],
                    );
              }, );
            });
          }
          catch(e){
            isLoading = false;
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString()))
            );

          }
        }, child: Text("Create Task"))
      ],),
    );
  }
}
