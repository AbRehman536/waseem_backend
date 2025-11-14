

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';

class TaskServices{
  String taskCollection = "TaskCollection";

  //create Task
  Future createTask(TaskModel model) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(taskCollection)
        .doc();
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }
 //update Task
  Future updateTask(TaskModel model)async{
      return await FirebaseFirestore.instance
          .collection(taskCollection)
          .doc(model.docId)
          .update({"title":model.title, "description": model.description});
  }

  //delete Task
  Future deleteTask(String taskID)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(taskID)
        .delete();
  }

  //mark as Completed
  Future markAsCompleted(TaskModel model,bool isCompleted)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(model.docId)
        .update({"isCompleted": model.isCompleted});
  }

  //get All Task
  Stream<List<TaskModel>> getAllTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .snapshots()
        .map((taskList)=>taskList.docs
        .map((taskJson)=>TaskModel.fromJson(taskJson.data()))
        .toList(),
    );
  }
  
  //get Incompleted Task
  Stream<List<TaskModel>> getInCompletedTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map((taskList)=>taskList.docs
        .map((taskJson)=>TaskModel.fromJson(taskJson.data()))
        .toList(),
    );
  }
  
  //get Completed Task
  Stream<List<TaskModel>> getCompletedTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .where('isCompleted', isEqualTo: true )
        .snapshots()
        .map((taskList)=>taskList.docs
        .map((taskJson)=>TaskModel.fromJson(taskJson.data()))
        .toList(),
    );
  }

    //favorite tasks
  Stream<List<TaskModel>> getFavoriteTask(String userID){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .where("favorite", arrayContains: userID)
        .snapshots()
        .map(
          (taskList) => taskList.docs
          .map((taskJson)=> TaskModel.fromJson(taskJson.data()))
          .toList(),
    );
  }


    //add to Favorite
      Future addToFavorite({
        required String userID,
        required String taskID})
        async{
        return await FirebaseFirestore.instance
          .collection(taskCollection)
          .doc(taskID)
          .update({"favorite" : FieldValue.arrayUnion([userID])});
      }

      //remove from Favorite
  Future removeFromFavorite({
    required String userID,
    required String taskID})
  async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(taskID)
        .update({"favorite" : FieldValue.arrayRemove([userID])});
  }
      }


