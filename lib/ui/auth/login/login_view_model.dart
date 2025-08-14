import 'package:event/providers/event_list_provider.dart';
import 'package:event/providers/user_provider.dart';
import 'package:event/ui/auth/login/login_navigator.dart';
import 'package:event/utils/app_routes.dart';
import 'package:event/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
typedef goToHome = void Function();
 class LoginViewModel extends ChangeNotifier{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late LoginNavigator navigator;
  var formKey = GlobalKey<FormState>();
  
  void login(BuildContext context) async{
     if (formKey.currentState?.validate() == true) {
    navigator.showLoading();
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        // var user = await FirebaseUtils.readDataFromFireStore(
        //   credential.user?.uid ?? '',
        // );
        // if (user == null) {
        //   return;
        // }
        // var usetProvider = Provider.of<UserProvider>(context, listen: false);
        // usetProvider.updateUser(user);

        // var eventListProvider = Provider.of<EventListProvider>(
        //   context,
        //   listen: false,
        // );
        // eventListProvider.changeSelectedIndex(0, usetProvider.currentUset!.id);
        // eventListProvider.getAllFavoriteEventFromFirsStore(
        //   usetProvider.currentUset!.id,
        // );

        navigator.hideLoading();
        navigator.showMessage(
          message: 'login Succesfuly',
          posActionsName: 'Ok',
          
          );
        
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          navigator.hideLoading();
        navigator.showMessage(message: 'email_or_password_is_wrong');
          
        } else if (e.code == 'network-request-failed') {
          navigator.hideLoading();
        navigator.showMessage(message: 'network_error');
          
        }
      } catch (e) {
        navigator.hideLoading();
        navigator.showMessage(message: 'error');
       
      }
     }
  }
}