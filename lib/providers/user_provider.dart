import 'package:firebase_backend/models/users.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  UserModel _userModel = UserModel();

  void setUser(UserModel model){
    _userModel = model;
    notifyListeners();
  }

  UserModel getUser() => _userModel;
}