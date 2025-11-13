import 'package:firebase_backend/models/task.dart';
import 'package:firebase_backend/services/task.dart';
import 'package:flutter/material.dart';

class UpdateTask extends StatefulWidget {
  final TaskModel model;
  const UpdateTask({super.key, required this.model});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    titleController = TextEditingController(
      text: widget.model.title.toString()
    );
    descriptionController = TextEditingController(
      text: widget.model.description.toString()
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(children: [
        TextField(controller: titleController,),
        TextField(controller: descriptionController,),
        isLoading ? Center(child: CircularProgressIndicator(),):
        ElevatedButton(onPressed: () async {
          try{
            isLoading = true;
            setState(() {});
            await TaskServices().updateTask(TaskModel(
              docId: widget.model.docId.toString(),
              title: titleController.text.toString(),
              description: descriptionController.text.toString(),
              isCompleted: false,
              createdAt: DateTime.now().millisecondsSinceEpoch
            )).then((val){
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Thank You"),
                      content: Text("Update Successfull"),
                      actions: [
                        TextButton(onPressed: (){}, child: Text("No")),
                        TextButton(onPressed: (){}, child: Text("Yes")),
                      ],
                    );
                  });
            });
          }
              catch(e){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString()))
            );
              }
        }, child: Text("Update Task"))
      ],),
    );
  }
}
