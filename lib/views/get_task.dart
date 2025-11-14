import 'package:firebase_backend/models/task.dart';
import 'package:firebase_backend/services/task.dart';
import 'package:firebase_backend/views/create_task.dart';
import 'package:firebase_backend/views/get_favorite_tasks.dart';
import 'package:firebase_backend/views/get_incompleted_task.dart';
import 'package:firebase_backend/views/get_priority.dart';
import 'package:firebase_backend/views/update_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'get_completed_task.dart';


class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>GetInCompletedTask()));
          }, icon: Icon(Icons.incomplete_circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>GetCompletedTask()));
          }, icon: Icon(Icons.circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>GetPriority()));
          }, icon: Icon(Icons.category)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>GetFavoriteTasks()));
          }, icon: Icon(Icons.favorite)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateTask()));
        },child: Icon(Icons.add),),
      body: StreamProvider.value(
        value: TaskServices().getAllTask(),
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                IconButton(onPressed: ()async{
                  try{
                    await TaskServices().deleteTask(taskList[index].docId.toString());
                  }
                      catch(e){
                        ScaffoldMessenger.of(context).showMaterialBanner(
                          MaterialBanner(
                            content: Text('Internet connection lost'),
                            backgroundColor: Colors.red,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                                },
                                child: Text('DISMISS'),
                              ),
                            ],
                          ),
                        );

                      }

                }, icon: Icon(Icons.delete)),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateTask(model: taskList[index])));
                }, icon: Icon(Icons.edit)),

                IconButton(onPressed: ()async{
                  if(taskList[index].favorite!.contains("1")){
                    await TaskServices().removeFromFavorite(
                        taskID: taskList[index].docId.toString(),
                        userID: "1");
                  }else{
                    await TaskServices().addToFavorite(
                        taskID: taskList[index].docId.toString() ,
                        userID: "1");
                  }
                }, icon: Icon(taskList[index].favorite!.contains("1") ? Icons.favorite : Icons.favorite_border)),
                Checkbox(
                    value: taskList[index].isCompleted,
                    onChanged: (val)async{
                      try {
                        await TaskServices()
                            .markAsCompleted(taskList[index], val!)
                            .then((val) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Task has been completed successfully",
                              ),
                            ),
                          );
                        });
                      }
                      catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    })
              ],),
            );
          },);
        },
      )
    );
  }
}
