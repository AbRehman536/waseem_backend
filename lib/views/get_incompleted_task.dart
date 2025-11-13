import 'package:firebase_backend/models/task.dart';
import 'package:firebase_backend/services/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetInCompletedTask extends StatelessWidget {
  const GetInCompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InCompleted Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: StreamProvider.value(
          value: TaskServices().getInCompletedTask(),
          initialData: [TaskModel()],
          builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(taskList[index].title.toString()),
                  subtitle: Text(taskList[index].description.toString()),
                );
              },);
          },
      ),

    );
  }
}
