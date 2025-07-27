import 'package:event/model/my_user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{

  MyUser? currentUset;

  void updateUser(MyUser newUser){
    currentUset = newUser;
    notifyListeners();
  }
}