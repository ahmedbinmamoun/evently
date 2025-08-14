import 'package:event/model/my_user.dart';
import 'package:event/providers/event_list_provider.dart';
import 'package:event/providers/user_provider.dart';
import 'package:event/ui/auth/register/register_navigator.dart';
import 'package:event/utils/app_routes.dart';
import 'package:event/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RegisterViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController(text: 'Ahmed');

  TextEditingController emailController = TextEditingController(
    text: 'ahmed@gmail.com',
  );

  TextEditingController passwordController = TextEditingController(
    text: '123456',
  );

  TextEditingController rePasswordController = TextEditingController(
    text: '123456',
  );

  var formKey = GlobalKey<FormState>();

  late RegisterNavigator navigator;
  void register({required BuildContext context}) async {
    if (formKey.currentState?.validate() == true) {
    // DialogUtils.showDialgLoding(context: context);
    navigator.showLoading('loading..');
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      // MyUser myUser = MyUser(
      //   id: credential.user?.uid ?? '',
      //   name: nameController.text,
      //   email: emailController.text,
      // );
      // await FirebaseUtils.addUserToFireStore(myUser);
      // var usetProvider = Provider.of<UserProvider>(context, listen: false);
      // usetProvider.updateUser(myUser);
      // var eventListProvider = Provider.of<EventListProvider>(
      //   context,
      //   listen: false,
      // );
      // eventListProvider.changeSelectedIndex(0, usetProvider.currentUset!.id);
      // eventListProvider.getAllFavoriteEventFromFirsStore(
      //   usetProvider.currentUset!.id,
      // );
      // DialogUtils.hideLoading(context: context);
      // DialogUtils.showMessage(
      //   context: context,
      //   message: AppLocalizations.of(context)!.register_succesfully,
      //   title: AppLocalizations.of(context)!.succesfully,
      //   posActionsName: AppLocalizations.of(context)!.ok,
      //   posAction: () {
      //     Navigator.pushNamedAndRemoveUntil(
      //       context,
      //       AppRoutes.homeRouteName,
      //       (route) => false,
      //     );
      //   },
      // );
      navigator.hideLoading();
      navigator.showMessage(
        message: AppLocalizations.of(context)!.register_succesfully,
        posActionsName: 'OK',
        
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.hideLoading();
        navigator.showMessage(
          message:
              AppLocalizations.of(context)!.the_password_provided_is_too_weak,
        );
        // DialogUtils.showMessage(
        //   context: context,
        //   message: AppLocalizations.of(context)!.the_password_provided_is_too_weak,
        //   title: AppLocalizations.of(context)!.error,
        //   posActionsName: AppLocalizations.of(context)!.ok,
        // );
      } else if (e.code == 'email-already-in-use') {
        // DialogUtils.hideLoading(context: context);
        navigator.hideLoading();
        navigator.showMessage(
          message: AppLocalizations.of(context)!.the_account_already_exists,
        );
        // DialogUtils.showMessage(
        //   context: context,
        //   message: AppLocalizations.of(context)!.the_account_already_exists,
        //   title: AppLocalizations.of(context)!.error,
        //   posActionsName: AppLocalizations.of(context)!.ok,
        // );
      } else if (e.code == 'network-request-failed') {
        // DialogUtils.hideLoading(context: context);
        navigator.hideLoading();
        navigator.showMessage(
          message: AppLocalizations.of(context)!.network_error,
        );
        // DialogUtils.showMessage(
        //   context: context,
        //   message: AppLocalizations.of(context)!.network_error,
        //   title: AppLocalizations.of(context)!.error,
        //   posActionsName: AppLocalizations.of(context)!.ok,
        // );
      }
    } catch (e) {
      // DialogUtils.hideLoading(context: context);
      navigator.hideLoading();
      navigator.showMessage(message: e.toString());
      // DialogUtils.showMessage(
      //   context: context,
      //   message: e.toString(),
      //   title: AppLocalizations.of(context)!.error,
      //   posActionsName: AppLocalizations.of(context)!.ok,
      // );
    }
    }
  }
}
