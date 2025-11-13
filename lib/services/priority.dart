

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_backend/models/priority.dart';

import '../models/task.dart';

class PriorityServices{
  String priorityCollection = "PriorityCollection";

  //create Priority
  Future createPriority(PriorityModel model) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(priorityCollection)
        .doc();
    return await FirebaseFirestore.instance
        .collection(priorityCollection)
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }
 //update Priority
  Future updatePriority(PriorityModel model)async{
      return await FirebaseFirestore.instance
          .collection(priorityCollection)
          .doc(model.docId)
          .update({"name":model.name,});
  }

  //delete Priority
  Future deletePriority(String priorityID)async{
    return await FirebaseFirestore.instance
        .collection(priorityCollection)
        .doc(priorityID)
        .delete();
  }
  //
  // //mark as Completed
  // Future markAsCompleted(TaskModel model,bool isCompleted)async{
  //   return await FirebaseFirestore.instance
  //       .collection(taskCollection)
  //       .doc(model.docId)
  //       .update({"isCompleted": model.isCompleted});
  // }

  //get All Priority
  Future<List<PriorityModel>> getALlPriority(){
    return FirebaseFirestore.instance
        .collection(priorityCollection)
        .get()
        .then(
        (priorityList) => priorityList.docs
            .map((priorityJson)=> PriorityModel.fromJson(priorityJson.data()))
            .toList(),
    );
  }
  
  //get Incompleted Task
  // Stream<List<TaskModel>> getInCompletedTask(){
  //   return FirebaseFirestore.instance
  //       .collection(taskCollection)
  //       .where("isCompleted", isEqualTo: false)
  //       .snapshots()
  //       .map((taskList)=> taskList.docs
  //             .map((taskJson)=> TaskModel.fromJson(taskJson.data()))
  //       .toList(),
  //   );
  // }
  
  //get Completed Task
  //   Stream<List<TaskModel>> getCompletedTask(){
  //   return FirebaseFirestore.instance
  //       .collection(taskCollection)
  //       .where("isCompleted", isEqualTo: true)
  //       .snapshots()
  //       .map((taskList)=> taskList.docs
  //           .map((taskJson)=> TaskModel.fromJson(taskJson.data()))
  //       .toList(),
  //   );
  //   }

}