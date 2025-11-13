import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_backend/models/users.dart';

class UserServices{
  String userCollection = "UserCollection";
  //create User
  Future createUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }
  //get User by Id
  Future<UserModel> getUserById(String userID) async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userID)
        .get()
        .then((user)=>UserModel.fromJson(user.data()!));
  }
  //Update User
  Future updateUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(model.docId)
        .update({
            'name' : model.name,
            'phone' :model.phone, 'address': model.address
    });
  }
}