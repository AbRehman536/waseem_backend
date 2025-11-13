import 'package:firebase_backend/models/priority.dart';
import 'package:firebase_backend/services/priority.dart';
import 'package:firebase_backend/views/create_priority.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetPriority extends StatelessWidget {
  const GetPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Priority"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>CreatePriority(model: PriorityModel(), isUpdateMode: false)));
      },child: Icon(Icons.add),),
      body: FutureProvider.value(
          value: PriorityServices().getALlPriority(),
          initialData: [PriorityModel()],
          builder: (context, child){
            List<PriorityModel> priorityList = context.watch<List<PriorityModel>>();
            return ListView.builder(
              itemCount: priorityList.length,
              itemBuilder: (BuildContext context, int index) { 
                return ListTile(
                  leading: Icon(Icons.star),
                  title: Text(priorityList[index].name.toString()),
                  trailing: IconButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context)=>CreatePriority(model: PriorityModel(), isUpdateMode: true)));
                  }, icon: Icon(Icons.edit)),
                );
              },);
          },
      ),
    );
  }
}
